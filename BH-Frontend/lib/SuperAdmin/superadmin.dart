import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ipApp/Login/User.dart';
import '../Navigation/bottom_navigation_bar.dart';
import '../Navigation/ontop_navigation_bar.dart';

void main() {
  runApp(SuperAdminPage());
}

class SuperAdminPage extends StatefulWidget {
  const SuperAdminPage({Key? key}) : super(key: key);
  static const primaryColor = const Color(0xff101C2B);
  static const borderColor = const Color(0xff896F4E);
  static const bgColor = const Color(0xff293441);
  @override
  State<SuperAdminPage> createState() => _SuperAdminPageState();
}

class _SuperAdminPageState extends State<SuperAdminPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SuperAdminPage.bgColor,
      appBar: OnTopNavigationBar(),
      body: Center(
        child: SuperAdmin(),
      ),
      bottomNavigationBar: ButtomNavigationBar(),
    );
  }
}

class SuperAdmin extends StatefulWidget {
  const SuperAdmin({Key? key}) : super(key: key);

  @override
  State<SuperAdmin> createState() => _SuperAdminState();
}

class _SuperAdminState extends State<SuperAdmin> {
  final TextEditingController _accController = TextEditingController();
  final List<String> _accounts = [];
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _accController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAllAdmins();
  }

  String token = myUser.getToken();

  Future<void> getAllAdmins() async {
    String baseUrl = "http://localhost:6969";
    final response = await http.get(
        Uri.parse(baseUrl + "/api/admin/get-all-admins"),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (int i = 0; i < data.length; i++) {
          _accounts.add(data[i]);
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> removeAdmin(int index) async {
    String baseUrl = "http://localhost:6969";
    String name = _accounts[index];

    final response = await http.post(
        Uri.parse(baseUrl + "/api/admin/remove-admin?username=$name"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User is no longer Admin'),
            content: const Text(''),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      setState(() {
        _accounts.removeAt(index);
      });
    }
  }

  Future<void> addAdmin(String name) async {
    String baseUrl = "http://localhost:6969";

    final response = await http.post(
        Uri.parse(baseUrl + "/api/admin/make-admin?username=$name"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User is now Admin'),
            content: const Text(''),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      setState(() {
        _accounts.add(name);
      });
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid User'),
            content: const Text(''),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: SuperAdminPage.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.supervisor_account,
                  color: Colors.white,
                  size: screenWidth < 700 ? 24 : 27,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Admin list',
                  style: TextStyle(
                      fontSize: screenWidth < 700 ? 22 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 25.0),
          TextField(
            focusNode: _focusNode,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                addAdmin(_accController.text);
                setState(() {
                  _accController.clear();
                });
              }
              _focusNode.requestFocus();
            },
            controller: _accController,
            cursorColor: SuperAdminPage.borderColor,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth < 700 ? 24 : 27,
              ),
              fillColor: Colors.white,
              hintText: 'Enter username',
              hintStyle: TextStyle(
                  color: Colors.white10,
                  fontSize: screenWidth < 700 ? 15.0 : 18.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: SuperAdminPage.borderColor,
                      width: screenWidth < 700 ? 2.0 : 3.0),
                  borderRadius: BorderRadius.circular(15.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: SuperAdminPage.borderColor,
                      width: screenWidth < 700 ? 2.0 : 3.0),
                  borderRadius: BorderRadius.circular(15.0)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: SuperAdminPage.borderColor,
                      width: screenWidth < 700 ? 2.0 : 3.0),
                  borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 25.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SuperAdminPage.borderColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              minimumSize: Size(
                  screenWidth < 700 ? 150 : 200, screenWidth < 700 ? 35 : 45),
            ),
            onPressed: () {
              addAdmin(_accController.text);
              setState(() {
                _accController.clear();
              });
            },
            child: Text(
              'Make admin',
              style: TextStyle(fontSize: screenWidth < 700 ? 15 : 18),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 25.0),
          Expanded(
            child: ListView.builder(
              itemCount: _accounts.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0, color: SuperAdminPage.borderColor),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          removeAdmin(index);
                        },
                      ),
                      SizedBox(width: screenWidth < 700 ? 15.0 : 25.0),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                              size: screenWidth < 700 ? 24 : 27,
                            ),
                            SizedBox(width: 10),
                            Text(
                              _accounts[index],
                              style: TextStyle(
                                  fontSize: screenWidth < 700 ? 15 : 18,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
