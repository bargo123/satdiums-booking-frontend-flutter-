import 'dart:convert';

CreateStadiumModel createStadiumModelFromJson(String str) => CreateStadiumModel.fromJson(json.decode(str));

String createStadiumModelToJson(CreateStadiumModel data) => json.encode(data.toJson());

class CreateStadiumModel {
  CreateStadiumModel({
    this.stadiums,
  });

  Stadiums stadiums;

  factory CreateStadiumModel.fromJson(Map<String, dynamic> json) => CreateStadiumModel(
        stadiums: json["stadiums"] != null && json["stadiums"] != {} ? Stadiums.fromJson(json["stadiums"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "name": stadiums.name,
        "price": stadiums.price,
        "days": stadiums.days.toJson(),
        "images": List<dynamic>.from(stadiums.images.map((x) => x)),
        "features": List<dynamic>.from(stadiums.features.map((x) => x)),
        "timesOfDay": stadiums.timesOfDay.toJson(),
      };
}

class Stadiums {
  Stadiums({
    this.id,
    this.name,
    this.price,
    this.days,
    this.images,
    this.features,
    this.timesOfDay,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String name;
  String price;
  Days days;
  List<String> images;
  List<String> features;
  TimesOfDay timesOfDay;
  String createdBy;
  String createdAt;
  String updatedAt;
  int v;

  factory Stadiums.fromJson(Map<String, dynamic> json) => Stadiums(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        days: Days.fromJson(json["days"]),
        images: List<String>.from(json["images"].map((x) => x)),
        features: List<String>.from(json["features"].map((x) => x)),
        timesOfDay: TimesOfDay.fromJson(json["timesOfDay"]),
        createdBy: json["createdBy"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );
}

class Days {
  Days({
    this.fromDay,
    this.toDay,
  });

  String fromDay;
  String toDay;

  factory Days.fromJson(Map<String, dynamic> json) => Days(
        fromDay: json["From Day"],
        toDay: json["To Day"],
      );

  Map<String, dynamic> toJson() => {
        "From Day": fromDay,
        "To Day": toDay,
      };
}

class TimesOfDay {
  TimesOfDay({
    this.from,
    this.to,
  });

  From from;
  From to;

  factory TimesOfDay.fromJson(Map<String, dynamic> json) => TimesOfDay(
        from: From.fromJson(json["From"]),
        to: From.fromJson(json["To"]),
      );

  Map<String, dynamic> toJson() => {
        "From": from.toJson(),
        "To": to.toJson(),
      };
}

class From {
  From({
    this.hour,
    this.min,
  });

  int hour;
  int min;

  factory From.fromJson(Map<String, dynamic> json) => From(
        hour: json["hour"],
        min: json["min"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "min": min,
      };
}
