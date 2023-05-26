// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ipApp/MyAccount/AccountPage.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import '../Login/User.dart';
import '../Navigation/bottom_navigation_bar.dart';
import '../Login/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final TextEditingController phoneChange = TextEditingController();
  final TextEditingController emailChange = TextEditingController();
  final String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Setting Account Profile',
      home: Scaffold(
        backgroundColor: const Color(0xFF293441),
        appBar: const OnTopNavigationBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 500,
                    alignment: AlignmentDirectional.center,
                    child: const Text(
                      'Personal Data',
                      style: TextStyle(
                        fontFamily: 'Louis George Cafe',
                        color: Color(0xFFe5e7e8),
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Last Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          myUser.name.toString(),
                          style: const TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'First Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          myUser.getSurName().toString(),
                          style: const TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          myUser.getPhone().toString(),
                          style: const TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          myUser.getEmail().toString(),
                          style: const TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Adress',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          myUser.getCity().toString(),
                          style: const TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFF0E1926),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 500,
                            alignment: AlignmentDirectional.center,
                            child: const Text(
                              'Change Personal Data',
                              style: TextStyle(
                                fontFamily: 'Louis George Cafe',
                                color: Color(0xFFe5e7e8),
                                fontSize: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  'Modify My Phone Number',
                                  style: TextStyle(
                                    fontFamily: 'Louis George Cafe',
                                    color: Color(0xFFe5e7e8),
                                    fontSize: 20,
                                  ),
                                ),
                                TextField(
                                    style: TextStyle(color: Color(0xFFe5e7e8)),
                                    controller: phoneChange,
                                    decoration: InputDecoration(
                                      labelText: 'New phone number',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFe5e7e8),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  'Modify My Email',
                                  style: TextStyle(
                                    fontFamily: 'Louis George Cafe',
                                    color: Color(0xFFe5e7e8),
                                    fontSize: 20,
                                  ),
                                ),
                                TextField(
                                    style: TextStyle(color: Color(0xFFe5e7e8)),
                                    controller: emailChange,
                                    decoration: InputDecoration(
                                      labelText: 'New email',
                                      labelStyle: TextStyle(
                                        color: Color(0xFFe5e7e8),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff896F4E),
                            ),
                            onPressed: () async {
                              String newPhone = phoneChange.value.text;
                              String newEmail = emailChange.value.text;
                              const String backendUrl =
                                  "http://127.0.0.1:6969/api/user-service/update-without";
                              final Uri uri = Uri.parse(backendUrl);

                              if (newPhone != '') myUser.setPhone(newPhone);

                              if (newEmail != '') myUser.setEmail(newEmail);

                              if (newEmail == '' && newPhone == '') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'No field has been modified!'),
                                      content: const Text(''),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const AccountPage()));
                                            // Close dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                final Map<String, dynamic> body = {
                                  'username': myUser.getUsername().toString(),
                                  'email': myUser.getEmail().toString(),
                                  'phone_number': myUser.getPhone().toString(),
                                  'name': myUser.getName().toString(),
                                  'surname': myUser.getSurName().toString(),
                                  'city': myUser.getCity().toString(),
                                };

                                try {
                                  final token = myUser.getToken();
                                  final response = await http.post(uri,
                                      body: body,
                                      headers: {
                                        'Authorization': 'Bearer $token'
                                      });
                                  if (response.statusCode == 200) {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Modify succesfully!'),
                                          content: const Text(''),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const AccountPage()));
                                                // Close dialog
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'No modify succesfully!'),
                                        content: const Text(''),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const AccountPage()));
                                              // Close dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const ButtomNavigationBar(),
      ),
    );
  }
}
