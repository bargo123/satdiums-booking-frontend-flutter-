class ImageModel {
  List<String> images;

  ImageModel({this.images});

  ImageModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    return data;
  }
}
