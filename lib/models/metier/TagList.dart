
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:flutter_app_fac/models/metier/simu.dart';
import 'package:provider/provider.dart';

class TagList extends ChangeNotifier {
  List<Tag> _tags = [];
  BuildContext context;

  TagList(this.context){
    var simu = Provider.of<Simu>(context,listen: false);
    tags.add(simu.tagAll);
    tags.add(simu.tagFav);
    tags.add(simu.tagFrance);
    tags.add(simu.tagMonde);
    tags.add(simu.tagNord);
    tags.add(simu.tagSud);

  }

  List<Tag> get tags => _tags;

  @override
  String toString() {
    return 'TagList{_tags: $_tags}';
  }
}