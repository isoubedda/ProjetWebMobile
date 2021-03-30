import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/ImageModel.dart';
import 'package:http/http.dart';

class ImageService extends ChangeNotifier {
  final entryPoint;

  ImageService(this.entryPoint);

  Future<List<ImageModel>> getAll () async {
    Response response = await http.get(entryPoint.urlImage);
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => ImageModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to get All images json');
    }
  }

  Future<void> removeImage(ImageModel image) async {
    Response response = await http.delete(image.links.elementAt(0).href);
    if(response.statusCode == 204 ) {
      print("Ok the image was remove");
    }else {
      throw new Exception('Faile to remove image');
    }
  }

  Future<ImageModel> postImage (File file, ImageModel image) async {
    Response response = await http.post(entryPoint.urlImage,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(image)
    );
    if(response.statusCode == 200 ) {
  
      var res = http.MultipartRequest('POST',Uri.parse(entryPoint.urlImage),);

      Map<String,String> headers={
      'Content-Type': "multipart/form-data",
      };

      res.files.add(
        http.MultipartFile(
           'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            contentType: MediaType('image','*'),
        ),
      );
      res.headers.addAll(headers);
      var result = await res.send();
      if (result.statusCode == 200) {
        return ImageModel.fromJson(json.decode(response.body));
      }else {
      throw new Exception('Faile to load the image file');
      }  
    }else {
      throw new Exception('Faile to load the image json');
    }
  }

  Future<ImageModel> patchImage (File file,ImageModel image) async {
    Response response = await http.patch(image.links.elementAt(0).href,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(image)
    );
    if(response.statusCode == 200 ) {
      var res = http.MultipartRequest('PATCH',Uri.parse(entryPoint.urlImage+"/"+image.id),);

      Map<String,String> headers={
      'Content-Type': "multipart/form-data",
      };

      res.files.add(
        http.MultipartFile(
           'file',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            contentType: MediaType('image','*'),
        ),
      );
      res.headers.addAll(headers);
      var result = await res.send();
      if (result.statusCode == 200) {
        return ImageModel.fromJson(json.decode(response.body));
      }else {
      throw new Exception('Faile to patch the image file');
      }  
    }else {
      throw new Exception('Faile to patch the image json');
    }

}}