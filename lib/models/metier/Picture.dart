import 'dart:io';

class Picture {
  String id;
  String url;


 Picture({this.id, this.url});


 Picture.fromJson(Map<String, dynamic> document) :
        id = document['id'],
        url = document['url'];

}