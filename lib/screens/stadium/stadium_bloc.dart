import 'dart:async';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/services/firebase_services.dart/firestore_service.dart';

class StadiumBloc {
  String _stadiumId;
  CreateStadiumModel _stadiumData = CreateStadiumModel();
  StreamController<CreateStadiumModel> stadiumController = StreamController<CreateStadiumModel>.broadcast();
  StadiumsService _fireStoreService = StadiumsService();

  Future<void> getStadiumData() async {
    if (_stadiumId != null) {
      _stadiumData = await _fireStoreService.getStadiumData(_stadiumId);
      stadiumController.sink.add(_stadiumData);
    }
  }

  set stadiumIdSetter(String id) {
    _stadiumId = id;
  }

  String get stadiumId => _stadiumId;
  get stadiumDataGetter => _stadiumData;
  Stream get stadiumControllerGetter => stadiumController.stream;
}
