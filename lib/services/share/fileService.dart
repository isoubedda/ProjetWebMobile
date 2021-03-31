import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {


  Future<String> localPath ()async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile(String fileName)  async {
    final path = await localPath();
    return File('$path/$fileName');
  }

  void writeFile( String data, String fileName) async {
    final file = await localFile(fileName);
    file.writeAsString(data);

  }


}