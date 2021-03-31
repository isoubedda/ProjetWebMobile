import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_fac/models/metier/PlaceModel.dart';
import 'package:flutter_app_fac/models/metier/UserModel.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_app_fac/models/metier/entrypoint.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_fac/models/metier/ImageModel.dart';
import 'package:http/http.dart';

class ImageService extends ChangeNotifier {
  final entryPoint;

  ImageService(this.entryPoint);

  Future<List<ImageModel>> getAll (UserModel user) async {
    Response response = await http.get(entryPoint.urlImage,
    headers: user.headers());
    if(response.statusCode == 200 ) {
      Iterable l = json.decode(response.body);
      return l.map((e) => ImageModel.fromJson(e)).toList();
    }else {
      throw new Exception('Faile to get All images json');
    }
  }
Future<File> getimage (PlaceModel place,UserModel user) async {
    Response response = await http.get(place.image.links[0].href,
    headers: user.headersImage());
    print("get image response status " + response.statusCode.toString());
    if(response.statusCode == 200 ) {

      final decodedBytes = base64Decode(response.body);
      var file = Io.File(place.label+".jpeg");
      file.writeAsBytesSync(decodedBytes);
      print(file.path);
      return file;
    }else {
      throw new Exception('Faile to get All images json');
    }
  }

  Future<void> removeImage(ImageModel image, UserModel user) async {
    Response response = await http.delete(image.links.elementAt(0).href,
    headers: user.headers());
    if(response.statusCode == 204 ) {
      print("Ok the image was remove");
    }else {
      throw new Exception('Faile to remove image');
    }
  }

  Future<ImageModel> postImage (File file, ImageModel image, UserModel user) async {
    // print("dans post image " + image.id);
    Response response = await http.post(entryPoint.getUrl2("images"),
     headers: user.headers(),
      body: jsonEncode(image)
    );
    print("response image post : " + response.statusCode.toString());
    print("response image post : " + response.body.toString());
    if(response.statusCode == 201 ) {
      print(response.body);

      ImageModel im = ImageModel.fromJson(json.decode(response.body));

     final bytes = await Io.File(file.path).readAsBytes();

      Response res = await http.post(Uri.parse(entryPoint.getUrl2("images")+ "/" + im.id), headers:user.headersImage(), body:bytes);

      // Map<String,String> headers=user.headersImage();
      // // res.files.add(
      // //   http.MultipartFile(
      // //      'file',
      // //       await file.readAsBytes().asStream(),
      // //       file.lengthSync(),
      // //     contentType: MediaType('image','jpeg'),
      // //   ),
      // // );
      // print(file.readAsBytes());
      // res.headers.addAll(user.headersImage());
      // res.headers.addAll(headers);
      // print(res.url);
      // print("header " + headers.toString());
      //
      //
      //
      // print(res.headers);
      // var result = await res.send();
      print(res.statusCode);

      if (res.statusCode == 201) {

        return ImageModel.fromJson(json.decode(response.body));
      }else {
      throw new Exception('Faile to load the image file');
      }  
    }else {
      throw new Exception('Faile to load the image json');
    }
  }

  Future<ImageModel> patchImage (File file,ImageModel image, UserModel user) async {
    Response response = await http.patch(image.links.elementAt(0).href,
      headers: user.headers(),
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
            contentType: MediaType('image/jpg','*'),
        ),
      );
      res.headers.addAll(user.headersImage());
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