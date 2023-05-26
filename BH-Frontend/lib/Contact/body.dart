import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff293441),
      child: Center(
        child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color(0xff896F4E),
          ),
          width: 450, // setați lățimea dorită
          height: 400, // setați înălțimea dorită
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 8),
                  Text(
                    'Pentru orice detalii sau nelamuriri va rugam sa ne contactati:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Email: grupaA3@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.black,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Telefon: 0710293847',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
