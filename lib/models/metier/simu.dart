import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';

class Simu extends ChangeNotifier {
  Tag tagAll = new Tag(name: "All");
  Tag tagFav = new Tag(name : "favoris");
  Tag tagSud = new Tag(name : "sud");
  Tag tagNord = new Tag (name : "nord");
  Tag tagFrance = new Tag(name : "France");
  Tag tagMonde = new Tag(name : "reste du monde");



}