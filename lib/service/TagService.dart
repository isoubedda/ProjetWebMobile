import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:flutter_app_fac/models/metier/TagModel.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class TagService extends ChangeNotifier{
static String urlName = "tags";
final EntryPoint entryPoint;

  TagService(this.entryPoint);

  Future<List<Tag>> getAll(UserModel user) async {
    Response response = await http.get(entryPoint.getUrl2(urlName),
    headers: user.headers());
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => Tag.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to get All tag json');
    }
  }


  Future<void> removeTag(Tag tag, UserModel user) async {
    Response response = await http.delete(tag.links.elementAt(0).href,
    headers: user.headers());
    if(response.statusCode == 204 ) {
    }else {
      throw new Exception('Faile to remove image');
    }
  }

  Future<Tag> postTag(Tag tag, UserModel user) async {
    Response response = await http.post(entryPoint.getUrl2(urlName),
     headers: user.headers(),
      body: jsonEncode(tag)
    );
    if(response.statusCode == 200 ) {
      return Tag.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Faile to load the tag');
    }
  }

  Future<Tag> patchPlace (Tag tag, UserModel user) async {
    Response response = await http.patch(tag.links[0].href,
    headers: user.headers(),
    body: json.encode(tag.toJson())
  );
    if(response.statusCode == 200 ) {
      return Tag.fromJson(json.decode(response.body));
    }else {
      throw new Exception('Faile to load the tag');
    }
  }



}