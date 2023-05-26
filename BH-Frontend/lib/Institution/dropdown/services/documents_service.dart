import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/document.dart';

class DocumentApi {
  final String baseUrl = 'http://localhost:6969/api';

  Future<List<Document>> getDocuments(String? name) async {
    final response =
        await http.get(Uri.parse('$baseUrl/tasks/get-doc-by-name/$name'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Document> documents =
          body.map((dynamic item) => Document.fromJson(item)).toList();
      return documents;
    } else {
      throw "Failed to load documents list";
    }
  }
}
