import 'package:flutter/material.dart';

class ButtomNavigationBar extends StatelessWidget {
  const ButtomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2.0,
            color: Color(0xff896F4E),
          ),
        ),
        color: Color(0xFF101C2B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
           Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Email: groupA3@gmail.com',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Phone: 0710293847',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}