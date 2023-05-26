// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import '../Login/User.dart';
import '../Navigation/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

import '../ToDo/main.dart';

class HistoryDocuments extends StatefulWidget {
  const HistoryDocuments({Key? key}) : super(key: key);

  @override
  State<HistoryDocuments> createState() => _HistoryDocumentsState();
}

class Document {
  String? status;
  int? idInstitution;
  int? idDocument;
  String? name;
  String? path;

  Document(
      {this.status, this.idInstitution, this.idDocument, this.name, this.path});

  String? getStatus() {
    return status;
  }

  int? getIdInstitution() {
    return idInstitution;
  }

  int? getIdDocument() {
    return idDocument;
  }

  String? getName() {
    return name;
  }

  String? getPath() {
    return path;
  }
}

class _HistoryDocumentsState extends State<HistoryDocuments> {
  List<String> tasksName = [];
  List<String> taskStatus = [];
  List<dynamic> documents = [];

  @override
  void initState() {
    super.initState();
    getInformations();
  }

  Future<void> getInformations() async {
    String username = myUser.getUsername();
    final String url =
        "http://localhost:6969/api/user-service/get-user-tasks?username=$username";
    final Uri uri = Uri.parse(url);
    try {
      final token = myUser.getToken();
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        documents = data;
        setState(() {
          for (final doc in documents) {
            tasksName.add(doc['TaskName']);
            taskStatus.add(doc['Status']);
          }
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Tasks',
      home: Scaffold(
        backgroundColor: const Color(0xFF293441),
        appBar: const OnTopNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                width: 500,
                alignment: AlignmentDirectional.center,
                child: const Text(
                  'Your Tasks',
                  style: TextStyle(
                    fontFamily: 'Louis George Cafe',
                    color: Color(0xFFe5e7e8),
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 8.0, left: 8.0),
                child: SizedBox(
                  height: 400,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      for (int i = 0; i < tasksName.length; ++i)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                color: Color(0xFF101c2b),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 35),
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        if (taskStatus[i] == 'done')
                                          Text(
                                            'Status: DONE',
                                            style: const TextStyle(
                                              fontFamily: 'Louis George Cafe',
                                              color: Colors.green,
                                              fontSize: 15,
                                            ),
                                          ),
                                        if (taskStatus[i] == 'pending')
                                          Text(
                                            'Status: IN PROGRESS',
                                            style: const TextStyle(
                                              fontFamily: 'Louis George Cafe',
                                              color: Colors.yellow,
                                              fontSize: 15,
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      'Task Name: ' + tasksName[i],
                                      style: const TextStyle(
                                        fontFamily: 'Louis George Cafe',
                                        color: Color(0xFFe5e7e8),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ToDoListPage(
                                                      TaskName: tasksName[i]),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color(0xFF896f4e)),
                                        ),
                                        child: const Text(
                                          'Inspect Task',
                                          style: TextStyle(
                                            fontFamily: 'Louis George Cafe',
                                            color: Color(0xFFe5e7e8),
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const ButtomNavigationBar(),
      ),
    );
  }
}
