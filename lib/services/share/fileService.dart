import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {


  Future<String> localPath ()async {
    final directory = await getApplicationDocumentsDirectory();
    print("directory " + directory.path);
    return directory.path;
  }

  Future<File> localFile(String fileName)  async {
    final path = await localPath();


    print("path dans file 2 :  $path");
    return File('$path/$fileName');
  }

  void writeFile( String data, String fileName) async {
    final file = await localFile(fileName);
    print("path dans file :  "+ file.path );
    file.writeAsString(data);

  }
//      ./kmlExport.kml


}