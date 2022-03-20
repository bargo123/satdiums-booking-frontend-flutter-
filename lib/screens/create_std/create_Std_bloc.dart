// ignore_for_file: close_sinks

import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/subjects.dart';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/core/enums/loading_Status_enum.dart';
import 'package:stdbook/core/utils/custom_state.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/models/images_model.dart';
import 'package:stdbook/services/firebase_services.dart/firestore_service.dart';
import 'package:stdbook/services/firebase_services.dart/image_services.dart';

class CreateStadiumBloc extends Bloc {
  List<String> featurs = ['Free Water', 'Clothes', 'Football', 'FreeHours'];
  List<String> pricePerHour = ['10JD', '20JD', '30JD', '40JD'];
  List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
  List<String> _newImages = [];
  List<String> _imagesToUpload = [];
  List<String> addedFeature = [];
  List<String> _deleteImages = [];
  List<String> urls = [];
  ImagesService _uploadImagesService = ImagesService();
  StadiumsService _stadiumsService = StadiumsService();
  Days daysToUpload = Days();
  TimesOfDay timesToUpload = TimesOfDay();
  String selectedFromDay;
  String selectedToDay;
  String selectedFromTime;
  String selectedToTime;
  String fieldName = '';
  String selectedPrices = "";
  // FireStoreService storeService = FireStoreService();
  BehaviorSubject<LoadingStatus> loadindStatusController = BehaviorSubject<LoadingStatus>();
  BehaviorSubject<List<String>> featuresController = BehaviorSubject<List<String>>();
  BehaviorSubject<List<String>> imagesController = BehaviorSubject<List<String>>();
  StreamController<String> priceController = StreamController<String>();
  BehaviorSubject<TimesOfDay> timeOfDayController = BehaviorSubject<TimesOfDay>();
  BehaviorSubject<Days> daysController = BehaviorSubject<Days>();

  bool checkisUrl(String title) {
    return Uri.parse(title).isAbsolute;
  }

  Future addImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    _newImages.add(result.files.first.path);
    _imagesToUpload.add(result.files.first.path);
    imagesController.sink.add(_newImages);
  }

  void removeImage(String imageName) async {
    if (checkisUrl(imageName)) {
      _newImages.removeWhere((element) => element == imageName);
      _deleteImages.add(imageName);
    } else {
      _newImages.removeWhere((element) => element == imageName);
      _imagesToUpload.removeWhere((element) => element == imageName);
    }
    imagesController.sink.add(_newImages);
  }

  Future changeImage(int index, String imageName) async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result.files.first.path != null) {
      removeImage(imageName);
      _newImages.insert(index, result.files.first.path);
      _imagesToUpload.insert(index, result.files.first.path);
      imagesController.sink.add(_newImages);
    }
  }

  Future<void> fireStoreData() async {
    var userId = await FlutterSecureStorage().read(key: AppConstants.userID);
    var stadData = await _stadiumsService?.getStadiumData(userId);
    if (stadData.stadiums != null) {
      setPrice(stadData.stadiums.price);
      setImages(stadData.stadiums.images);
      setFeatures(stadData.stadiums.features);
      _setDurationData(stadData.stadiums.timesOfDay, stadData.stadiums.days);
      fieldName = stadData.stadiums.name;
    }
    loadindStatusController.sink.add(LoadingStatus.Finished);
  }

  void setImages(List<String> images) {
    if (images != null && images.isNotEmpty) {
      _newImages = images;
      imagesController.sink.add(images);
    }
  }

  void setFeatures(List<String> features) {
    if (features != null && features.isNotEmpty) {
      addedFeature = features;
      featuresController.sink.add(addedFeature);
    }
  }

  void setPrice(String price) {
    if (price != null) {
      selectedPrices = price;
      print(selectedPrices);
      priceController.sink.add(selectedPrices);
    }
  }

  void _setDurationData(TimesOfDay timesOfDay, Days daysData) {
    _updateFromAndToSelectedTimes(timesOfDay);
    _setDays(daysData);
  }

  void checkIsFromDay(String day, bool isFrom) {
    if (isFrom) {
      daysToUpload.fromDay = day;
    } else {
      daysToUpload.toDay = day;
    }
    _setDays(daysToUpload);
  }

  void _setDays(Days daysData) {
    if (daysData != null) {
      print("here");
      daysToUpload = daysData;
      daysController.sink.add(daysData);
    }
  }

  void checkIsFromTime(bool isFrom, TimeOfDay timeOfDay) {
    if (isFrom) {
      timesToUpload.from = From(hour: timeOfDay.hour, min: timeOfDay.minute);
    } else {
      timesToUpload.to = From(hour: timeOfDay.hour, min: timeOfDay.minute);
    }
    _updateFromAndToSelectedTimes(timesToUpload);
  }

  void _updateFromAndToSelectedTimes(TimesOfDay timesOfDay) {
    if (timesOfDay != null) {
      timesToUpload = timesOfDay;
      timeOfDayController.sink.add(timesOfDay);
    }
  }

  bool isButtonEnabled() {
    bool fieldNameCheck = fieldName != null && fieldName.isNotEmpty;
    bool priceCheck = selectedPrices != null && selectedPrices.isNotEmpty;
    bool imagesCheck = _imagesToUpload.isNotEmpty || _deleteImages.isNotEmpty;
    return (imagesCheck && fieldNameCheck && priceCheck);
  }

  Future<void> uploadDataToFireStore() async {
    if (_newImages.length >= 2) {
      var images = await uploadImagesToStorage();
      print(timesToUpload.toJson());
      var dataToUpload = CreateStadiumModel(
          stadiums: Stadiums(
              days: daysToUpload,
              features: addedFeature,
              images: images.images,
              name: fieldName,
              price: selectedPrices,
              timesOfDay: timesToUpload));
      await _stadiumsService.uploadStadiumData(dataToUpload);
    }
  }

  Future<ImageModel> uploadImagesToStorage() async {
    return await _uploadImagesService.uploadImages(_newImages);
  }
}
