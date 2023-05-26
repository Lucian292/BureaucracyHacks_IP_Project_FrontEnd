// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ipApp/Login/User.dart';
import 'package:ipApp/MyAccount/ChangePassword.dart';
import 'package:ipApp/MyAccount/HistoryDocuments.dart';
import 'package:ipApp/MyAccount/ProfilePage.dart';
import 'package:ipApp/MyAccount/DocumentsPage.dart';
import '../Navigation/bottom_navigation_bar.dart';
import '../Navigation/ontop_navigation_bar.dart';
import '../Login/login.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Page',
      home: Scaffold(
        backgroundColor: const Color(0xFF101c2b),
        appBar: const OnTopNavigationBar(),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background_buildings.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Welcome, ${myUser.getUsername()}!',
                    style: const TextStyle(
                      fontFamily: 'Book Antiqua Font',
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1000,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.95,
                            child: Container(
                              padding: const EdgeInsets.only(top: 50, bottom: 0),
                              child: Container(
                                width: 500,
                                height: 480,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF293441),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: const Text(
                                        'My Account',
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Color(0xFFe5e7e8),
                                          fontFamily: 'Louis George Cafe',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFe5e7e8),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(builder: (BuildContext context) => const ProfilePage())),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 20, left: 10),
                                              child: Image.asset(
                                                'assets/images/date_personale.png',
                                                width: 75,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 15, left: 0),
                                              child: const Text(
                                                'Personal Data',
                                                style: TextStyle(
                                                  color: Color(0xFFe5e7e8),
                                                  fontFamily: 'Louis George Cafe',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFe5e7e8),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => const HistoryDocuments())),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 18, left: 10),
                                              child: Image.asset(
                                                'assets/images/istoricul_cautarilor.png',
                                                width: 75,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 15, left: 0),
                                              child: const Text(
                                                'Search History',
                                                style: TextStyle(
                                                  color: Color(0xFFe5e7e8),
                                                  fontFamily: 'Louis George Cafe',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFe5e7e8),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(builder: (BuildContext context) => const ChangePasswordPage())),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 20, left: 10),
                                              child: Image.asset(
                                                'assets/images/schimbare_parola.png',
                                                width: 75,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 15, left: 0),
                                              child: const Text(
                                                'Change Password',
                                                style: TextStyle(
                                                  color: Color(0xFFe5e7e8),
                                                  fontFamily: 'Louis George Cafe',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFe5e7e8),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(builder: (BuildContext context) => const MyDocuments())),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 20, left: 10),
                                              child: Image.asset(
                                                'assets/images/document_in_decurs.png',
                                                width: 70,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 15, left: 0),
                                              child: const Text(
                                                'Documents',
                                                style: TextStyle(
                                                  color: Color(0xFFe5e7e8),
                                                  fontFamily: 'Louis George Cafe',
                                                  fontSize: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:(){
                                        isLogged = false;
                                        isAdmin = false;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (BuildContext context) => const Login()));
                                      },
                                      child: Container(
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFe5e7e8),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 20, left: 10),
                                              child: Image.asset(
                                                'assets/images/deconectare.png',
                                                width: 75,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 15, left: 0),
                                              child: const Text(
                                                'LogOut',
                                                style: TextStyle(
                                                  color: Color(0xFFe5e7e8),
                                                  fontFamily: 'Louis George Cafe',
                                                  fontSize: 30,
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
        bottomNavigationBar: const ButtomNavigationBar(),
      ),
    );
  }
}
