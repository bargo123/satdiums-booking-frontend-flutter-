import 'dart:async';

import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:stdbook/core/utils/formater.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/models/durations_model.dart';
import 'package:stdbook/services/firebase_services.dart/firestore_service.dart';

class BookBloc {
  // FireStoreService _fireStoreService = FireStoreService();
  StreamController<DateTime> dateController = StreamController<DateTime>.broadcast();
  StreamController<String> _selectedFromController = StreamController<String>.broadcast();
  StreamController<String> _selectedToController = StreamController<String>.broadcast();
  StreamController<List<String>> timesController = StreamController<List<String>>.broadcast();
  List<String> fromDates = [];
  List<String> _timeFromunAvailableDates = [];
  List<String> _timeTounAvailableDates = [];

  From fromTime;
  From toTime;
  String _bookedDate;
  String message;
  String _selectedFromVal;
  String _selectedToVal;
  String stdiumId;
  Duration duration;

  void updateTheSelectedDate(DateTime selectedDate) {
    dateController.sink.add(selectedDate);
    _bookedDate = selectedDate.toIso8601String();
  }

  void _updateFromAndToSelectedTimes(List<String> times) {
    if (times != null && times.isNotEmpty) {
      timesController.sink.add(times);
    }
  }

  void getAllAvilableTime() {
    for (int i = fromTime?.hour; i <= toTime?.hour; i++) {
      fromDates.add(Formater().durationToString(i, fromTime.min));
    }
    _updateFromAndToSelectedTimes(fromDates);
  }

  // void checkIfDateAvilable() {
  //   //Todo
  // }

  set setFromTimes(String value) {
    if (value != null) {
      _selectedFromController.sink.add(value);
      _selectedFromVal = value;
    }
  }

  set setToTimes(String value) {
    if (value != null) {
      _selectedToController.sink.add(value);
      _selectedToVal = value;
    }
  }

  bool bookCheck() {
    bool value;
    bool checkTimes = _selectedFromVal != null && _selectedToVal != null;
    if (checkTimes == false) {
      message = "please Check the times you booked";
      value = false;
    } else if (DateTime.parse(_bookedDate).isBefore(DateTime.now())) {
      value = false;
      message = "please check dates on the calender";
    } else {
      value = true;
    }
    return value;
  }

  Future<void> getTimesFireStore() async {
    // // var data = await _fireStoreService.getAllDurations(stdiumId);
    // data.durations.forEach((element) {
    //   _timeFromunAvailableDates.add(element.timefrom);
    //   _timeTounAvailableDates.add(element.timeto);
    // });
  }

  Future<void> setDuration() async {
    // await _fireStoreService.uploadDurationData(Durations(date: _bookedDate, timefrom: _selectedFromVal, timeto: _selectedToVal), stdiumId);
  }

  String mixFromToDuration() {
    return '$_selectedFromVal - $_selectedToVal';
  }

  List<String> get timeFromunAvailableDates => _timeFromunAvailableDates;
  List<String> get timeTounAvailableDates => _timeTounAvailableDates;
  Stream<String> get selectedFromStream => _selectedFromController.stream;
  Stream<String> get selectedToStream => _selectedToController.stream;
}
