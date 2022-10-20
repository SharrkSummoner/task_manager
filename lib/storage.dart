import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<List> readTask() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = jsonDecode(await file.readAsString()) ;

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeTask(List task) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$task');
  }
}