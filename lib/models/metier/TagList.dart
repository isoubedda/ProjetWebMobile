
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:provider/provider.dart';

class TagList extends ChangeNotifier {
  List<Tag> _tags = [];
  BuildContext context;

//  TagList(this.context);

  TagList(this.context){
    tags.add(Provider.of<Tag>(context, listen: false));
    tags.add(Tag("Favoris"));
  }

  List<Tag> get tags => _tags;

  @override
  String toString() {
    return 'TagList{_tags: $_tags}';
  }
}