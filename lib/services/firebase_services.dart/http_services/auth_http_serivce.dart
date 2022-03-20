import 'dart:convert';
import 'package:stdbook/core/repository/http_repository.dart';
import 'package:stdbook/models/login_model.dart';
import 'package:stdbook/models/token_model.dart';

class AuthService {
  Future<TokenModel> login(LoginDataModel loginDataModel) async {
    print(loginDataModel.toJson());
    var req = await HttpRepository()
        .makeRequest(requestType: HttpRequest.POSTAUTH, url: 'auth/login', bodyMap: loginDataModel.toJson());
    print(jsonDecode(req.body));
    return TokenModel.fromJson(jsonDecode(req.body));
  }
}
