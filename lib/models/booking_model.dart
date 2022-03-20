class BookingModel {
  List<Data> data;

  BookingModel({this.data});

  BookingModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String name;
  String bookedDate;
  String bookedtime;
  String status;
  String bookDuration;

  Data({this.name, this.bookedDate, this.bookedtime, this.status, this.bookDuration});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bookedDate = json['bookedDate'];
    bookedtime = json['bookedtime'];
    status = json['status'];
    bookDuration = json['bookDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookedDate'] = this.bookedDate;
    data['bookedtime'] = this.bookedtime;
    data['status'] = this.status;
    data['bookDuration'] = this.bookDuration;
    return data;
  }
}
