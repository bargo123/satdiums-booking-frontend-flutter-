class DurationsModel {
  List<Durations> durations;

  DurationsModel({this.durations});

  DurationsModel.fromJson(Map<String, dynamic> json) {
    if (json['durations'] != null) {
      durations = new List<Durations>();
      json['durations'].forEach((v) {
        durations.add(new Durations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.durations != null) {
      data['durations'] = this.durations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Durations {
  String date;
  String timefrom;
  String timeto;

  Durations({this.date, this.timefrom, this.timeto});

  Durations.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timefrom = json['timefrom'];
    timeto = json['timeto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timefrom'] = this.timefrom;
    data['timeto'] = this.timeto;
    return data;
  }
}
