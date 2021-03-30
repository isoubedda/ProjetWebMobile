

import 'package:hive/hive.dart';

part 'Links.g.dart';

@HiveType(typeId: 3)
class Links {
  @HiveField(0)
  String _rel;
  @HiveField(1)
  String _href;

  
  Links(this._rel, this._href);
  
  String get rel => _rel;
  set rel(String rel) => _rel = rel;
  String get href => _href;
  set href(String href) => _href = href;

  Links.fromJson(Map<String, dynamic> document) :
    _rel = document['rel'],
    _href = document['href'];
  
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this._rel;
    data['href'] = this._href;
    return data;
  }

  }
  
  
