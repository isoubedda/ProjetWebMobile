import 'Links.dart';

class ShareModel {
  bool write;
  bool read;
  String value;
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