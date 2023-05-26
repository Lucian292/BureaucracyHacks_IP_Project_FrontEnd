import 'dart:convert';
import 'dart:typed_data';

import 'package:ipApp/Institution/dropdown/services/download_service.dart';
import 'package:ipApp/Institution/dropdown/services/login_service.dart';
import 'package:ipApp/Institution/dropdown/services/starttask_service.dart';
import 'package:ipApp/Institution/dropdown/services/upload_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Navigation/bottom_navigation_bar.dart';
import '../../Navigation/ontop_navigation_bar.dart';
import '../../ToDo/main.dart';
import './models/document.dart';
import 'models/tokenProvider.dart';
import 'services/task_service.dart';
import 'services/documents_service.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import '../../Login/User.dart';

void main() {
  runApp(const App2());
}

class App2 extends StatelessWidget {
  const App2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedOption;
  final TasksService _tasksService = TasksService();
  late List<String> _options = [];

  @override
  void initState() {
    super.initState();
    {
      _loadTasksNames();
    }
    ;
  }

  Future<void> _loadTasksNames() async {
    final tasksNames = await _tasksService.getTasksNames();
    setState(() {
      _options = tasksNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const OnTopNavigationBar(),
      // appBar: AdaptiveNavBar(
      //   screenWidth: sw,
      //   backgroundColor: const Color(0xFF101C2B),
      //   leading: Image.asset(
      //     'images/logo-ip.png',
      //     width: 50,
      //     height: 50,
      //   ),
      //   navBarItems: [
      //     NavBarItem(
      //       text: "Home",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "Institution",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "Contact",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "My account",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //   ],
      // ),
      body: Center(
          child: Container(
        //toata pagina
        color: const Color(0xff293441),
        child: Center(
          child: Container(
            //width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: const Color(0xff293441),
            ),
            //width: 350, // setați lățimea dorită
            //height: 400, // setați înălțimea dorită
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    //icon: Container(width: 0, height: 0),
                    dropdownColor: const Color(0xff896F4E),
                    decoration: InputDecoration(
                      //contentPadding: const EdgeInsets.symmetric(
                      //   horizontal: 16.0, vertical: 8.0),
                      filled: true,
                      fillColor: const Color(0xff896F4E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: 'Selecteaza document',
                    ),
                    value: _selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOption = newValue.toString();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MyOtherPage(selectedOption: _selectedOption!),
                          ),
                        );
                      });
                    },
                    items: _options.map((option) {
                      return DropdownMenuItem(
                        value: option,
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}

class MyOtherPage extends StatefulWidget {
  final String selectedOption;
  late String nameOption = selectedOption;

  //const MyOtherPage({Key? key}) : super(key: key);
  MyOtherPage({Key? key, required this.selectedOption}) : super(key: key);

  @override
  _MyOtherPageState createState() => _MyOtherPageState();
}

class _MyOtherPageState extends State<MyOtherPage> {
  final DocumentApi _documentApi = DocumentApi();
  late List<Document>? _documents = [];
  final StartTask _startTask = StartTask();
  late String _tododocuments;
  final FileUploader _fileUploader = FileUploader();
  final FileDownloader _fileDownloader = FileDownloader();
  bool isButtonVisible1 = true;
  bool isButtonVisible2 = true;

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  Future<void> _uploadFile(int id) async {
    try {
      print(id);
      String result = await _fileUploader.uploadFile(id);
      print('File uploaded successfully. Result: $result');
    } catch (e) {
      print('Failed to upload file: $e');
    }
  }

  Future<void> _downloadFile(int id) async {
    final downloader = FileDownloader();
    try {
      await downloader.downloadFile(id);
      print('File download completed.');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _loadDocuments() async {
    final documents = await _documentApi.getDocuments(widget.selectedOption);
    setState(() {
      _documents = documents;
    });
  }

  Future<void> _loadToDoDocuments(String username, String taskName) async {
    final todo_documents = await _startTask.startTask(username, taskName);
    print(todo_documents);
    setState(() {
      _tododocuments = todo_documents;
    });
  }

  Future<void> _loadExtraDocuments(String name) async {
    widget.nameOption = name;
    final documents = await _documentApi.getDocuments(name);
    setState(() {
      _documents = documents;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff293441),
      appBar: const OnTopNavigationBar(),
      // appBar: AdaptiveNavBar(
      //   screenWidth: sw,
      //   backgroundColor: const Color(0xFF101C2B),
      //   leading: Image.asset(
      //     'images/logo-ip.png',
      //     width: 50,
      //     height: 50,
      //   ),
      //   navBarItems: [
      //     NavBarItem(
      //       text: "Home",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "Institution",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "Contact",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //     NavBarItem(
      //       text: "My account",
      //       onTap: () {
      //         Navigator.pushNamed(context, "routeName");
      //       },
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            //height: 1200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Acte necesare pentru eliberare ${widget.nameOption}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Inria Serif",
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromARGB(255, 137, 111, 78),
                    ),
                    //height: 1000, //setarea asta s-ar putea sa ti faca probleme
                    width: 600,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _documents?.length ?? 0,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              //+
                              //EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}. ${_documents?[index].name} ( Price: ${_documents?[index].price} )',
                                    style: const TextStyle(
                                      fontFamily: 'Inria Serif',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    maxLines: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: _documents?[index].file ==
                                                  '0' &&
                                              _documents?[index].path != '0',
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: TextButton(
                                            onPressed: () {
                                              print("Link pressed");
                                              _loadExtraDocuments(
                                                  _documents?[index].name ??
                                                      '');
                                              // launchUrl(Uri.parse(_documents?[
                                              //             index]
                                              //         .path ??
                                              //     '')); // Replace with your logic to redirect to the link
                                            },
                                            child: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Link',
                                                textAlign: TextAlign.left,
                                                // Align text to the left
                                                style: TextStyle(
                                                  color: Color(0xFF101C2B),
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              _documents?[index].file != '0',
                                          maintainSize: true,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _downloadFile(_documents?[index]
                                                      .documentId ??
                                                  0);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              primary: const Color(0xFF101C2B),
                                            ),
                                            child: const Text('Download'),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Visibility(
                                          visible:
                                              myUser.getRoles() == "ROLE_ADMIN",
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _uploadFile(_documents?[index]
                                                      .documentId ??
                                                  0);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              primary: const Color(0xFF101C2B),
                                            ),
                                            child: const Text('Upload'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Image.asset('images/schema.png'),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          // Set padding from content above
                          child: ElevatedButton(
                            onPressed: () {
                              _loadToDoDocuments(
                                  myUser.getUsername(), widget.nameOption);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ToDoListPage(
                                      TaskName: widget.selectedOption),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              // Customize background color
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff293441)),

                              // Customize button padding
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                              ),

                              // Customize border
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: const BorderSide(
                                      color: Color(0xFF101C2B)),
                                ),
                              ),
                            ),
                            child: const Text('Incepe operatiunea',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image.asset('images/orase.png'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
