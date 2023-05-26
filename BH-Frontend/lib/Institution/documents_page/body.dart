import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 41, 52, 65),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Acte necesare pentru eliberare buletin',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Inria Serif",
                    fontSize: 30,
                    color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color.fromARGB(255, 137, 111, 78),
                ),
                height: 700,
                width: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "      1. Certificat de nastere (original si  fotocopie) \n   Link: \n\n      2. Certificat de casatorie (original si fotocopie) \n   Link: \n\n      3. Certificate de nastere ale copiilor sub 14 ani (original si copie) \n   Link: \n\n      4. Cerere pentru eliberare act de identitate \n   Link: \n\n      5. Documentul cu care se face dovada adresei de domiciliu (original şi fotocopie)  \n   Link: \n\n      6. Cartea de alegător - dacă a deținut un astfel de document  \n   Link: \n\n      7. Chitanţa reprezentând contravaloarea cărţii de identitate (7 lei) \n   Link:",
                      style: TextStyle(
                          fontFamily: "Inria Serif",
                          fontSize: 20,
                          color: Colors.white),
                    ), //text
                    Image.asset('images/schema.png'),
                  ],
                ),
              ),
              Image.asset('images/orase.png'),
            ],
          ),
        ),
      ),
    );
  }
}
