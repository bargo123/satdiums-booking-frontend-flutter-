class HomePageModel {
  List<Stadiums> stadiums;
  int length;

  HomePageModel({this.stadiums, this.length});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['stadiums'] != null) {
      stadiums = <Stadiums>[];
      json['stadiums'].forEach((v) {
        stadiums.add(new Stadiums.fromJson(v));
      });
    }
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stadiums != null) {
      data['stadiums'] = this.stadiums.map((v) => v.toJson()).toList();
    }
    data['length'] = this.length;
    return data;
  }
}

class Stadiums {
  String sId;
  String name;
  String price;
  List<String> images;
  String createdBy;

  Stadiums({this.sId, this.name, this.price, this.images, this.createdBy});

  Stadiums.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    images = json['images'].cast<String>();
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['images'] = this.images;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
