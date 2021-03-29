

import 'TargetHints.dart';
import 'package:hive/hive.dart';

part 'Links.g.dart';

@HiveType(typeId: 3)
class Links {
  @HiveField(0)
  String _rel;
  @HiveField(1)
  String _href;
  @HiveField(2)
  String _targetMediaType;
  @HiveField(3)
  TargetHints _targetHints;
  
  Links(this._rel, this._href, this._targetMediaType , this._targetHints);
  
  String get rel => _rel;
  set rel(String rel) => _rel = rel;
  String get href => _href;
  set href(String href) => _href = href;
  String get targetMediaType => _targetMediaType;
  set targetMediaType(String targetMediaType) =>
      _targetMediaType = targetMediaType;
  TargetHints get targetHints => _targetHints;
  set targetHints(TargetHints targetHints) => _targetHints = targetHints;

  Links.fromJson(Map<String, dynamic> document) :
    _rel = document['rel'],
    _href = document['href'],
    _targetMediaType = document['targetMediaType'],
    _targetHints = document['targetHints'] != null
    ? new TargetHints.fromJson(document['targetHints'])
    : null;
  
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this._rel;
    data['href'] = this._href;
    data['targetMediaType'] = this._targetMediaType;
    if (this._targetHints != null) {
      data['targetHints'] = this._targetHints.toJson();
    }
    return data;
  }

  }
  
  
