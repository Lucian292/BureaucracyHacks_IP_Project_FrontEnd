import 'package:flutter/material.dart';
import '../Feedback_view.dart';
import 'institution.dart';
import 'institution_service.dart';

class InstitutionMobile extends StatefulWidget {
  const InstitutionMobile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InstitutionMobileState createState() => _InstitutionMobileState();
}

class _InstitutionMobileState extends State<InstitutionMobile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final InstitutionService
  _institutionService = InstitutionService();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 700),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff896F4E)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'images/primaria.png',
                                  width: 250,
                                  height: 200,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "${_institution!.name}",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 50),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff896F4E),
                                        // aici setezi culoarea butonului
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              16), // aici setezi forma butonului
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const FeedbackView()));
                                      },
                                      child: const Text(
                                        'Vezi Feedback', // aici poți seta textul butonului
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
                            )
                          ],
                        ),
                        Container(
                          width: 350,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 150),
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 25),
                                              ),
                                              Text(
                                                "Contact:",
                                                style: TextStyle(fontSize: 20),
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
                                                Icons.phone,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              Text(
                                                'Telefon: ${_institution!.phoneNumber}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                                Icons.fax,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              Container(
                                                width:200,
                                              child: Text(
                                                'Website: ${_institution!.website}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 150),
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 25),
                                              ),
                                              Text(
                                                "Program:",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25),
                                              ),
                                              Text(
                                                'Luni: ${_institution!.monday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Marti: ${_institution!.tuesday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Miercuri: ${_institution!.wednesday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Joi: ${_institution!.thursday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Vineri: ${_institution!.friday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Sambata: ${_institution!.saturday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                                              Text(
                                                'Duminica: ${_institution!.sunday}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(top: 150),
                                ),
                                Column(
                                  children: <Widget>[
                                    Row(children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 25),
                                              ),
                                              Text(
                                                "Adresa:",
                                                style: TextStyle(fontSize: 20),
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
                                                Icons.location_city_rounded,
                                                color: Colors.black,
                                                size: 16,
                                              ),
                                              Container(
                                                width: 200,
                                              child: Text(
                                                '${_institution!.address}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
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
