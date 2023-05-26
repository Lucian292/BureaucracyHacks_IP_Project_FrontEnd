// ignore_for_file: file_names
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:ipApp/Login/User.dart';
import '../Navigation/bottom_navigation_bar.dart';
import '../Navigation/ontop_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class MyDocuments extends StatefulWidget {
  const MyDocuments({Key? key}) : super(key: key);

  @override
  State<MyDocuments> createState() => _MyDocumentsState();
}

class Photo {
  late File image;
  late String name;

  Photo(File file, String desc) {
    image = file;
    name = desc;
  }

  void setImage(File image) {
    this.image = image;
  }

  void setName(String name) {
    this.name = name;
  }

  File getImage() {
    return image;
  }

  String getName() {
    return name;
  }
}

class _MyDocumentsState extends State<MyDocuments> {
  List<Photo> images = [];
  final TextEditingController _text = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<File?> pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      List<int> bytes = result.files.single.bytes!;
      return File(result.files.single.name)..writeAsBytes(bytes);
    }
    return null;
  }

  Future<void> uploadImage(File imageFile, String username) async {
    var uri = Uri.parse('http://localhost:6969/api/image/upload');

    var request = http.MultipartRequest('POST', uri);
    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType.parse(
          lookupMimeType(imageFile.path) ?? 'application/octet-stream'),
    );

    request.files.add(multipartFile);
    request.fields['username'] = username;

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else if (response.statusCode == 400) {
        print('Bad request: ${response.reasonPhrase}');
      } else {
        print('Unexpected error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

// Call the uploadImage function
  void callUploadImage(BuildContext context) async {
    // Pick an image file
    File? imageFile = await pickImage();

    if (imageFile != null) {
      // Get the username from somewhere
      String username = myUser.getUsername();

      // Call the uploadImage function
      await uploadImage(imageFile, username);

      // Show a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Image uploaded successfully!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No image selected.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Name of document'),
            content: TextField(
              controller: _text,
              decoration: const InputDecoration(hintText: "Put a name"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Documents',
      home: Scaffold(
        backgroundColor: const Color(0xFF293441),
        appBar: const OnTopNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 500,
                  alignment: AlignmentDirectional.center,
                  child: const Text(
                    'Personal Documents',
                    style: TextStyle(
                      fontFamily: 'Louis George Cafe',
                      color: Color(0xFFe5e7e8),
                      fontSize: 35,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FloatingActionButton(
                        backgroundColor: const Color(0xFF101c2b),
                        onPressed: () async {
                          await _displayDialog(context);
                          String text = _text.text;
                          callUploadImage(context);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Color(0xFFe5e7e8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Add your personal photos',
                          style: TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50, right: 8.0, left: 8.0),
                  child: SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        Photo p = images[index];
                        String pName = p.getName();
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(children: <Widget>[
                            Text(
                              'Document#$index: $pName',
                              style: TextStyle(
                                  fontSize: 25, color: Color(0xFFe5e7e8)),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Color(0xFFe5e7e8),
                                size: 20,
                              ),
                            )
                          ]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const ButtomNavigationBar(),
      ),
    );
  }
}
