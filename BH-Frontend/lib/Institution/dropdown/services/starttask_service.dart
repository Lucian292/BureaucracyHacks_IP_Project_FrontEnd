import 'package:http/http.dart' as http;

class StartTask{
  Future<String> startTask(String username, String taskName) async {
    final url = Uri.parse("http://localhost:6969/api/user-service/add-user-task?username=$username&taskName=$taskName");
    final request = http.MultipartRequest('POST', url);
    final response = await request.send();

    if (response.statusCode == 200) {
      print("Task started");
      return "Task started";
    } else {
      throw Exception('Failed to upload documents. Status code: ${response.statusCode}');
    }

  }}