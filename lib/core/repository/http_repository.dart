import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/locator.dart';

enum HttpRequest { POST, GET, POSTAUTH, POSTIMAGE }

class HttpRepository {
  Future<http.Response> makeRequest(
      {HttpRequest requestType, String url, Map<String, dynamic> bodyMap, List<String> paths}) async {
    var token = await getIt<FlutterSecureStorage>().read(key: AppConstants.token);
    var newUrl = Uri.parse("http://192.168.100.28:3000/api/v1/$url");
    String body;
    body = json.encode(bodyMap);
    http.Response request;
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "bearer $token"
    };

    switch (requestType) {
      case HttpRequest.GET:
        request = await http.get(newUrl, headers: header);
        break;
      case HttpRequest.POST:
        print(body);
        request = await http.post(newUrl, body: body, headers: header);
        break;
      case HttpRequest.POSTAUTH:
        request = await http.post(newUrl, body: body, headers: header);
        break;
      case HttpRequest.POSTIMAGE:
        var imageRequest = http.MultipartRequest("POST", newUrl);
        for (var path in paths) {
          imageRequest.files.add(await http.MultipartFile.fromPath('Images', path));
        }
        imageRequest.headers.addAll({"Authorization": "bearer $token"});
        var result = await imageRequest.send();
        request = await http.Response.fromStream(result);
        break;
    }
    return request;
  }
}
