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
    //write = json['Write'];
    read = json['Read'];
    value = json['Value'];
    //if (json['_links'] != null) {
    //  lLinks = new List<Links>();
    //  json['_links'].forEach((v) {
    //    lLinks.add(new Links.fromJson(v));
    //  });
    //}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['Write'] = this.write;
    data['Read'] = this.read;
    //data['Value'] = this.value;
    //if (this.lLinks != null) {
    //  data['_links'] = this.lLinks.map((v) => v.toJson()).toList();
    //}
    return data;
  }
}