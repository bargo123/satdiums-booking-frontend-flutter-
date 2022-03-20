import 'dart:async';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/locator.dart';
import 'package:stdbook/models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/firebase_services.dart/http_services/auth_http_serivce.dart';

class LoginController {
  AuthService authService = AuthService();
  StreamController<String> tokenController = StreamController<String>.broadcast();
  Future signIn(String email, String password) async {
    LoginDataModel model = LoginDataModel(email: email, password: password);
    await authService.login(model).then((value) async {
      await getIt<FlutterSecureStorage>().write(key: AppConstants.token, value: value.token);
      await getIt<FlutterSecureStorage>().write(key: AppConstants.userID, value: value.user.sId);
      tokenController.sink.add(value.token);
    });
  }
}
