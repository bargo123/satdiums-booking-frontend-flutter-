import 'dart:convert';

import 'package:stdbook/core/repository/http_repository.dart';
import 'package:stdbook/models/booking_model.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/models/durations_model.dart';
import 'package:stdbook/models/home_page_model.dart';

class StadiumsService {
  Future<void> uploadStadiumData(CreateStadiumModel createStadiumModel) async {
    var response = await HttpRepository()
        .makeRequest(bodyMap: createStadiumModel.toJson(), requestType: HttpRequest.POST, url: "stadiums");
  }

  Future<CreateStadiumModel> getStadiumData(String id) async {
    var response = await HttpRepository().makeRequest(requestType: HttpRequest.GET, url: "stadiums/$id");
    print(response.body);
    return CreateStadiumModel.fromJson(jsonDecode(response.body));
  }

  Future<HomePageModel> getHomePageData() async {
    var response = await HttpRepository().makeRequest(requestType: HttpRequest.GET, url: "stadiums");
    print(response.body);
    return HomePageModel.fromJson(jsonDecode(response.body));
  }

  Future<void> uploadBookingData(Data bookingModel, String id) async {
    // var data = await getAllBookedSession(id);
    // data.data.add(bookingModel);
    // await firebaseFirestore.collection('bookingCollection').doc(id).set(data.toJson());
  }

  Future<BookingModel> getAllBookedSession(String id) async {
    // var data = await firebaseFirestore.collection('bookingCollection').doc(id).get();
    // return BookingModel.fromJson(data.data());
  }

  Future<void> uploadDurationData(Durations durations, String id) async {
    // var data = await getAllDurations(id);
    // data.durations.add(durations);
    // await firebaseFirestore.collection('durationsCollection').doc(id).set(data.toJson());
  }

  Future<DurationsModel> getAllDurations(String id) async {
    // try {
    //   var data = await firebaseFirestore.collection('durationsCollection').doc(id).get();
    //   return DurationsModel.fromJson(data.data());
    // } catch (_) {
    //   return DurationsModel(durations: []);
    // }
  }

  Future<Durations> getSpeciecDate(String id, String date) async {
    // try {
    //   return await firebaseFirestore
    //       .collection('durationsCollection')
    //       .doc(id)
    //       .get()
    //       .then((value) => DurationsModel.fromJson(value.data()).durations.where((element) => element.date == date)) as Durations;
    // } catch (_) {
    //   return Durations(date: "", timefrom: "", timeto: "");
    // }
  }
}
