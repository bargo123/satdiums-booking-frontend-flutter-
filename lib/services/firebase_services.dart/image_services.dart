import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stdbook/core/repository/http_repository.dart';
import 'package:stdbook/models/images_model.dart';

class ImagesService {
  Future<ImageModel> uploadImages(List<String> paths) async {
    HttpRepository httpRepository = HttpRepository();
    var response =
        await httpRepository.makeRequest(url: "stadiums/images", paths: paths, requestType: HttpRequest.POSTIMAGE);
    return ImageModel.fromJson(jsonDecode(response.body));
  }
}
