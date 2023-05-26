import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:flutter/material.dart';
import '../Contact/main.dart';
import '../Home/landing.dart';
import '../Institution/institutions/main.dart';
import '../Login/User.dart';
import '../Login/login.dart';
import '../MyAccount/AccountPage.dart';
import '../Register/register.dart';
import '../Institution/dropdown/main.dart';
import '../SuperAdmin/superadmin.dart';
import 'colors.dart';

class OnTopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const OnTopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AdaptiveNavBar(
          bottomOpacity: 0.8,
          title: Text('Bureacracy Hacks'),
          screenWidth: MediaQuery.of(context).size.width,
          backgroundColor: const Color(0xFF101C2B),
          leading: Image.asset(
            'images/logo-ip.png',
            width: 50,
            height: 50,
          ),
          navBarItems: [
            NavBarItem(
              text: "Home",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const MyApp()));
              },
            ),
            NavBarItem(
              text: "Institution",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const App()));
              },
            ),
            NavBarItem(
              text: "Contact",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AppBarExample()));
              },
            ),
            if (isLogged)
              NavBarItem(
                text: 'Docs',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const App2()));
                },
              ),
            if (isLogged)
              NavBarItem(
                text: "Account",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AccountPage()));
                },
              ),
            if (!isLogged)
              NavBarItem(
                text: "Login",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const Login()));
                },
              ),
            if (!isLogged)
              NavBarItem(
                text: "Register",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const Register()));
                },
              ),
            if (isLogged && isAdmin)
              NavBarItem(
                text: "Admin",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SuperAdminPage()));
                },
              ),
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(3.0),
              child: Container(
                height: 3.0,
                color: burntgold.shade700,
              )));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
