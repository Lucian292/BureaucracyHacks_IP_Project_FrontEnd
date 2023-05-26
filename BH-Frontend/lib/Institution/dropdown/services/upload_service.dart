import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';


class FileUploader {
  Future<String> uploadFile(int id) async {
    final url = Uri.parse('http://localhost:6969/api/tasks/upload/byId/$id');
    final request = http.MultipartRequest('POST', url);

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      request.files.add(http.MultipartFile.fromBytes('file', file.bytes!, filename: file.name));
    } else {
      throw Exception('No file selected.');
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return responseBody;
    } else {
      throw Exception('Failed to upload file. Status code: ${response.statusCode}');
    }
  }
}

