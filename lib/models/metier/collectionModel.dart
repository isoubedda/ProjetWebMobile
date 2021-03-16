
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:provider/provider.dart';

class CollectionModel extends ChangeNotifier {
  List<Tag> _tags = [];

  CollectionModel(this._tags);

  List<Tag> get tags => _tags;

  set tags(List<Tag> value) {
    _tags = value;
  }

  @override
  String toString() {
    return 'CollectionModel{_tags: $_tags}';
  }
}

class CollectionList extends ChangeNotifier {
  List<CollectionModel> _collections = [];

  CollectionList(context) {
    List<Tag> tag =[];
    tag.add(Provider.of<Tag>(context, listen: false));
    CollectionModel collectionModel = new CollectionModel(tag);
    _collections.add(collectionModel);
  }

  List<CollectionModel> get collections => _collections;

  @override
  String toString() {
    return 'CollectionList{_collections: $_collections}';
  }
}