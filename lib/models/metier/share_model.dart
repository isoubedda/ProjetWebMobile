import 'Links.dart';

class ShareModel {
  //dans les spec pas dans postman
  bool write;
  bool read;
  String value;
  //dans les spec pas dans postman
  List<Links> lLinks;

  ShareModel({this.write, this.read});

  ShareModel.fromJson(Map<String, dynamic> json) {

    read = json['Read'];
    value = json['Value'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Read'] = this.read;
    return data;
  }
}