import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ipApp/Login/forgot_password.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import 'package:ipApp/Register/register.dart';
import 'package:ipApp/Login/forgot_password.dart';
import '../MyAccount/AccountPage.dart';
import '../Navigation/bottom_navigation_bar.dart';
import 'User.dart';

void main() {
  runApp(MaterialApp(
    // Register the route generator for the "/register.dart" route
    onGenerateRoute: (settings) {
      if (settings.name == '/register.dart') {
        return MaterialPageRoute(builder: (context) => const Register());
      } else if (settings.name == '/forgot_password.dart') {
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      }
      return null;
    },
    home: const Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const primaryColor = Color(0xff101C2B);
  static const borderColor = Color(0xff896F4E);
  static const bgColor = Color(0xff293441);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Login.bgColor,
      appBar: const OnTopNavigationBar(),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: LoginForm(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ButtomNavigationBar(),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Container(
      height: screenWidth < 700 ? 520.0 : 650.0,
      width: screenWidth < 700 ? 320.0 : 450.0,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Login.primaryColor,
        border: Border.all(
            color: Login.borderColor, width: screenWidth < 700 ? 3.0 : 4.0),
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Log In',
            style: TextStyle(
                fontSize: screenWidth < 700 ? 25 : 35, color: Colors.white),
          ),
          SizedBox(
            height: screenWidth < 700 ? 20.0 : 30.0,
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
              cursorColor: Login.borderColor,
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
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
                Icons.vpn_key,
                color: Colors.white,
                size: screenWidth < 700 ? 15 : 22,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Parola: ',
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
              obscureText: true,
              controller: passwordController,
              cursorColor: Login.borderColor,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Login.borderColor,
                        width: screenWidth < 700 ? 2.0 : 3.0),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 30.0),
          ElevatedButton(
            onPressed: () async {
              const String backendUrl = "http://127.0.0.1:6969/api/auth/login";
              final Uri uri = Uri.parse(backendUrl);
              final Map<String, dynamic> body = {
                'usernameOrEmail': emailController.text,
                'password': passwordController.text,
              };
              try {
                final response = await http.post(uri, body: body);
                if (response.statusCode == 200) {
                  // Successful authentication
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Authenticated user'),
                        content: const Text(''),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              // Handle the response data here
                              final responseData = json.decode(response.body);
                              final user = responseData['user'];
                              // Example: Retrieve the token and user data
                              final token = responseData['token'].toString();
                              final name = user['name'].toString();
                              final username = user['username'].toString();
                              final surname = user['surname'].toString();
                              final email = user['email'].toString();
                              final password = user['password'].toString();
                              final phoneNumber =
                                  user['phone_number'].toString();
                              final city = user['city'].toString();
                              final createdAt = user['created_at'].toString();
                              final role = user['roles'].toString();
                              String roleString = role;
                              late int index;
                              for (int i = 0; i < roleString.length; ++i) {
                                if (roleString[i] == 'n') {
                                  index = i + 6;
                                  break;
                                }
                              }
                              String nameRole = '';
                              for (int i = index; i < roleString.length; ++i) {
                                if (roleString[i] == ',') {
                                  break;
                                }
                                nameRole += roleString[i];
                              }

                              isLogged = true;
                              myUser = User(
                                  roles: nameRole,
                                  token: token,
                                  name: name,
                                  surname: surname,
                                  username: username,
                                  email: email,
                                  password: password,
                                  phone_number: phoneNumber,
                                  created_at: createdAt,
                                  city: city);

                              if (myUser.getRoles() == 'ROLE_ADMIN') {
                                isAdmin = true;
                              }
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const AccountPage()));
                              // Close dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                  // Perform further actions with the token and user data
                } else {
                  // Authentication failed
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Failed to authenticate user'),
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
                      title: const Text('Can not authenticate user'),
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
              backgroundColor: Login.borderColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              minimumSize: Size(400, screenWidth < 700 ? 35 : 45),
            ),
            child: Text(
              'Log in',
              style: TextStyle(fontSize: screenWidth < 700 ? 18 : 20),
            ),
          ),
          SizedBox(height: screenWidth < 700 ? 15.0 : 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot_password.dart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Login.bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minimumSize: Size(400, screenWidth < 700 ? 35 : 45),
                ),
                child: Text(
                  'Ti-ai uitat parola?',
                  style: TextStyle(fontSize: screenWidth < 700 ? 18 : 20),
                ),
              ),
              SizedBox(height: screenWidth < 700 ? 45.0 : 50.0),
              Text(
                '''Sau inregistreaza-te daca nu 
              ai inca un cont:''',
                style: TextStyle(
                    fontSize: screenWidth < 700 ? 15 : 22, color: Colors.white),
              ),
              SizedBox(
                height: screenWidth < 700 ? 10.0 : 15.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register.dart');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Login.borderColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  minimumSize: Size(400, screenWidth < 700 ? 35 : 45),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: screenWidth < 700 ? 18 : 20),
                ),
              ),
              SizedBox(height: screenWidth < 700 ? 15.0 : 20.0),
            ],
          )
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
