import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import 'package:ipApp/Register/register.dart';
import '../MyAccount/AccountPage.dart';
import 'package:ipApp/Login/login.dart';
import '../Navigation/bottom_navigation_bar.dart';
import 'User.dart';



void main() {
  runApp(MaterialApp(
    // Register the route generator for the "/register.dart" route
    onGenerateRoute: (settings) {
      if (settings.name == '/register.dart') {
        return MaterialPageRoute(builder: (context) => const Register());
      }
      return null;
    },
    home: const ForgotPassword(),
  ));
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const primaryColor = Color(0xff101C2B);
  static const borderColor = Color(0xff896F4E);
  static const bgColor = Color(0xff293441);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ForgotPassword.bgColor,
      appBar: const OnTopNavigationBar(),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: ForgotPasswordForm(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}
class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final emailController = TextEditingController();
    final usernameController = TextEditingController();
    final newPasswordController = TextEditingController();

    return Container(
      height: screenWidth < 700 ? 480.0 : 600.0,
      width: screenWidth < 700 ? 320.0 : 450.0,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: ForgotPassword.primaryColor,
        border: Border.all(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 3.0 : 4.0),
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ti-ai uitat parola? No problemo! \n\nInsereaza email-ul si numele de utilizator curent cu o noua parola: ',
            style: TextStyle( fontSize: screenWidth < 700 ? 15 : 20, color: Colors.white), textAlign:TextAlign.center,
          ),
          SizedBox(
            height: screenWidth < 700 ? 15.0 : 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.email,
                color: Colors.white,
                size: screenWidth < 700 ? 15 : 22,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Email: ',
                style: TextStyle(
                  fontSize: screenWidth < 700 ? 18 : 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenWidth < 700 ? 5.0 : 10.0,
          ),
          SizedBox(
            height: screenWidth < 700 ? 35 : 45,
            child: TextField(
              cursorColor: ForgotPassword.borderColor,
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth < 700 ? 15.0 : 20.0,
          ),
          Row(
            children: [
              Icon(
                Icons.account_box,
                color: Colors.white,
                size: screenWidth < 700 ? 15 : 22,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Username: ',
                style: TextStyle(
                  fontSize: screenWidth < 700 ? 18 : 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth < 700 ? 5.0 : 10.0),
          SizedBox(
            height: screenWidth < 700 ? 35 : 45,
            child: TextField(
              obscureText: false,
              controller: usernameController,
              cursorColor: ForgotPassword.borderColor,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.vpn_key,
                color: Colors.white,
                size: screenWidth < 700 ? 15 : 22,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'New password: ',
                style: TextStyle(
                  fontSize: screenWidth < 700 ? 18 : 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenWidth < 700 ? 5.0 : 10.0,
          ),
          SizedBox(
            height: screenWidth < 700 ? 35 : 45,
            child: TextField(
              obscureText: true,
              cursorColor: ForgotPassword.borderColor,
              controller: newPasswordController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ForgotPassword.borderColor, width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth < 700 ? 15.0 : 20.0,
          ),
          ElevatedButton(
            onPressed: () async {
              const String backendUrl = "http://127.0.0.1:6969/api/auth/forgot-password";
              final Uri uri = Uri.parse(backendUrl);
              /*final Map<String, dynamic> body = {
                "email": usernameController.text,
                "username": emailController.text,
                "newPassword" : newPasswordController.text,
              };*/
              final Map<String, dynamic> body = {
                'username': usernameController.text,
                'email': emailController.text,
                'newPassword' : newPasswordController.text,
              };
              print(body);
              try {
                final response = await http.post(uri, body: body);
                if (response.statusCode == 200) {
                  // Successful password change
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Password changed successfully'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {



                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (BuildContext context) => const Login()));
                              // Close dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // Perform further actions with the token and user data
                } else {
                  print(response.statusCode);
                  // Pass change failed
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Failed to change password for user'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // Handle the failed authentication here
                }
              } catch (e) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Can not change password for user'),
                      content: const Text(''),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog
                          },
                        ),
                      ],
                    );
                  },
                );
                // Handle any network or other errors here
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ForgotPassword.borderColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              minimumSize: Size(400, screenWidth < 700 ? 35 : 45),
            ),
            child: Text(
              'Change Password',
              style: TextStyle(fontSize: screenWidth < 700 ? 18 : 20),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 20.0),

        ],
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: const Center(
        child: Text('Register Page'),
      ),
    );
  }
}