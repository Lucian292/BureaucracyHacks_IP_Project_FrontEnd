import 'package:flutter/material.dart';
import '../Feedback_view.dart';
import 'institution.dart';
import 'institution_service.dart';

class InstitutionDesktop extends StatefulWidget {
  @override
  _InstitutionDesktopState createState() => _InstitutionDesktopState();
}

class _InstitutionDesktopState extends State<InstitutionDesktop> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  InstitutionService _institutionService = InstitutionService();
  Institution? _institution;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          //height: 200,
          color: const Color(0xff293441),
          // culoarea containerului
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: 500,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff293441),
                    // culoarea băii de căutare
                    border: Border.all(
                      width: 2,
                      color: const Color(0xff896F4E),
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Institution Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an institution name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff896F4E),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                final institution = await _institutionService
                                    .getInstitutionByName(_nameController.text);
                                setState(() {
                                  _institution = institution;
                                });
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Failed to load institution'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: const Text('Find Institution'),
                        ),
                        //const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
              if (_institution != null) ...[
                Center(
                  //alignment: AlignmentDirectional.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 30, bottom: 30),
                    width: double.infinity,
                    constraints: BoxConstraints(maxWidth: 950),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff896F4E)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(

                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'images/primaria.png',
                                        width: 300,
                                        height: 300,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Text(
                                          "${_institution!.name}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          maxLines: 3,
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(top: 50),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xff896F4E),
                                                // aici setezi culoarea butonului
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16), // aici setezi forma butonului
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const FeedbackView()));
                                              },
                                              child: const Text(
                                                'Vezi Feedback',
                                                // aici poți seta textul butonului
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  // aici setezi culoarea textului butonului
                                                  fontSize:
                                                      16, // aici setezi mărimea textului butonului
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //inchis container
                        Container(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,//cum sunt aliniate contact program si aia
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 30),
                                          ),
                                          Text(
                                            "Contact:",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Telefon: ${_institution!.phoneNumber}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    'Website: ${_institution!.website}',
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(top: 150),
                                  ),
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 30),
                                          ),
                                          Text(
                                            "Program:",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          //mainAxisAlignment: MainAxisAlignment.start,

                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(10)),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Luni: ${_institution!.monday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Marti: ${_institution!.tuesday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Miercuri: ${_institution!.wednesday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Joi: ${_institution!.thursday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Vineri: ${_institution!.friday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Sambata: ${_institution!.saturday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    'Duminica: ${_institution!.sunday}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 30),
                                          ),
                                          Text(
                                            "Adresa:",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 25),
                                                ),
                                                Icon(
                                                  Icons.location_city_rounded,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                Container(
                                                  width: 245,
                                                  child: Text(
                                                    '${_institution!.address}',
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Image.asset('images/orase.png'),
              // Expanded(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // prima imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // a doua imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // a treia imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // a treia imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // a treia imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: Image.asset(
              //           'images/orase.png', // a treia imagine
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
