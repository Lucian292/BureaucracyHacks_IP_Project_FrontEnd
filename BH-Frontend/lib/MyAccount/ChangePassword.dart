// ignore_for_file: file_names
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import '../Login/User.dart';
import '../Navigation/bottom_navigation_bar.dart';
import 'AccountPage.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change Password',
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
                      'Change Password',
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
                          'My Current Password',
                          style: TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                            style: TextStyle(color: Color(0xFFe5e7e8)),
                            obscureText: true,
                            controller: currentPassword,
                            decoration: InputDecoration(
                              labelText: 'Your password',
                              labelStyle: TextStyle(
                                color: Color(0xFFe5e7e8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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
                          'My New Password',
                          style: TextStyle(
                            fontFamily: 'Louis George Cafe',
                            color: Color(0xFFe5e7e8),
                            fontSize: 20,
                          ),
                        ),
                        TextField(
                            style: TextStyle(color: Color(0xFFe5e7e8)),
                            obscureText: true,
                            controller: newPassword,
                            decoration: InputDecoration(
                              labelText: 'New password',
                              labelStyle: TextStyle(
                                color: Color(0xFFe5e7e8),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
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
                      bool goodPassword = false;
                      String myPassword = currentPassword.value.text;
                      String futurePassword = newPassword.value.text;
                      if (myPassword == '' || futurePassword == '') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('No field has been completed!'),
                              content: const Text(''),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (BuildContext context) => const AccountPage()));
                                    // Close dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        const String backendUrlVerify = "http://127.0.0.1:6969/api/user-service/verifyPassword";
                        const String backednUrlUpdate = "http://127.0.0.1:6969/api/user-service/updatePassword";
                        final Uri uriVerify = Uri.parse(backendUrlVerify);
                        final Uri uriUpdate = Uri.parse(backednUrlUpdate);
                        final Map<String, dynamic> body = {
                          'username': myUser.getUsername().toString(),
                          'password': myPassword,
                        };
                        final Map<String, dynamic> bodyUpdate = {
                          'username': myUser.getUsername().toString(),
                          'password': futurePassword,
                        };
                        try {
                          final response = await http.post(uriVerify, body: body);
                          if (response.statusCode == 200) {
                            goodPassword = true;
                          }
                          if (goodPassword) {
                            try {
                              final responseUpdate = await http.post(uriUpdate, body: bodyUpdate);
                              if (responseUpdate.statusCode == 200) {
                                myUser.setPassword(futurePassword);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Modify succesfully!'),
                                      content: const Text(''),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext context) => const AccountPage()));
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
                                    title: const Text('No modify succesfully!'),
                                    content: const Text(''),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) => const AccountPage()));
                                          // Close dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                          else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Incorrect Password!'),
                                  content: const Text(''),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => const AccountPage()));
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
                                title: const Text('No modify succesfully!'),
                                content: const Text(''),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) => const AccountPage()));
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
                    child: Text('Save'),
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
