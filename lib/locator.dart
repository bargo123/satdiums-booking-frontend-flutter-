import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stdbook/screens/login/login_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<LoginController>(LoginController());
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
}
