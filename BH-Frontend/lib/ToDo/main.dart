import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:ipApp/Login/User.dart';
import 'package:ipApp/Navigation/ontop_navigation_bar.dart';
import 'package:location/location.dart' as locator;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(ToDoListPage(
      TaskName: '',
    ));

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class ToDoListPage extends StatelessWidget {
  final GlobalKey<_MyMapState> _mapKey = GlobalKey<_MyMapState>();

  final String TaskName;

  ToDoListPage({super.key, required this.TaskName});

  void updateLocations(String finalLocation) {
    _MyMapState? mapState = _mapKey.currentState;
    if (mapState != null) {
      mapState.getDirections(finalLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'InriaSerif',
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(Colors.white),
            fillColor: MaterialStateProperty.all(Colors.white),
          )),
      home: Scaffold(
        appBar: OnTopNavigationBar(),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0XFF293441),
            border: Border(
              top: BorderSide(
                width: 1,
                color: Color(0xFF896F4E),
              ),
              bottom: BorderSide(
                width: 1,
                color: Color(0xFF896F4E),
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(bottom: 30.0, top: 30.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    MyMap(key: _mapKey),
                    ToDoList(
                        updateLocations: updateLocations, taskName: TaskName),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: SizedBox(
          height: 50,
          child: Footer(
            backgroundColor: const Color(0XFF101C2B),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email: groupA3@gmail.com',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'InriaSerif'),
                ),
                Text(
                  'Phone: 0710293847',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'InriaSerif'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyMapState extends State<MyMap> {
  late maps.GoogleMapController mapController;
  List<maps.LatLng> locations = [];

  Future<void> clearMap() async {
    setState(() {
      locations.clear();
      polylines.clear();
    });
  }

  Future<void> getDirections(String routes) async {
    clearMap();
    _getCurrentLocation();
    const baseUrl = 'http://localhost:6969/api/directions/get-directions';

    //print(routes);
    String token = myUser.getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      body: routes,
      headers: {
        'Content-Type': 'text/plain;charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    //print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> directions = data;

      directions.forEach((direction) {
        final double latitude = double.parse(direction['lat']);
        print(latitude);
        final double longitude = double.parse(direction['lng']);
        print(longitude);
        locations.add(maps.LatLng(latitude, longitude));
      });
    } else {
      throw Exception('Failed to get directions.');
    }

    setState(() {
      _getRoute();
    });
  }

  void _onMapCreated(maps.GoogleMapController controller) {
    mapController = controller;
  }

  locator.Location location = locator.Location();
  late maps.LatLng _currentLocation;

  Set<maps.Polyline> polylines = {};

  Future<List<maps.LatLng>> getRoute(
      maps.LatLng origin, maps.LatLng destination) async {
    String url =
        'https://router.project-osrm.org/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?geometries=geojson';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];
      List<maps.LatLng> points =
          coordinates.map((c) => maps.LatLng(c[1], c[0])).toList();
      return points;
    } else {
      throw Exception('Failed to load route');
    }
  }

  void _getCurrentLocation() async {
    try {
      var userLocation = await location.getLocation();
      setState(() {
        _currentLocation =
            maps.LatLng(userLocation.latitude!, userLocation.longitude!);
        if (locations.isEmpty) {
          locations.add(_currentLocation);
        } else {
          locations[0] = _currentLocation;
        }
      });
    } catch (e) {
      print('Could not get the user location: $e');
    }
  }

  Future<void> _getRoute() async {
    List<maps.LatLng> polyline = [];

    for (int i = 0; i < locations.length - 1; i++) {
      List<maps.LatLng> segment =
          await getRoute(locations[i], locations[i + 1]);
      polyline.addAll(segment);
      Color color = Color.fromARGB(
        255,
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
      );
      polylines.add(
        maps.Polyline(
          polylineId: maps.PolylineId('route$i'),
          color: color,
          width: 5,
          points: segment,
        ),
      );
    }

    setState(() {
      polylines = polylines.toSet(); // Assign the updated polylines set
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 3.0,
          color: const Color(0xFF896F4E),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: SizedBox(
          width: 900.0,
          height: 500.0,
          child: maps.GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: maps.CameraPosition(
              target: locations.isNotEmpty
                  ? locations[0]
                  : const maps.LatLng(47.1585, 27.6014),
              zoom: 13.5,
            ),
            markers: locations
                .map(
                  (location) => maps.Marker(
                    markerId: maps.MarkerId(location.toString()),
                    position: location,
                    infoWindow: const maps.InfoWindow(
                      title: 'Locatie',
                    ),
                  ),
                )
                .toSet(),
            polylines: polylines,
          ),
        ),
      ),
    );
  }
}

class ToDoList extends StatefulWidget {
  final void Function(String finalLocation) updateLocations;
  final String taskName;

  const ToDoList(
      {Key? key, required this.updateLocations, required this.taskName})
      : super(key: key);

  @override
  State<ToDoList> createState() =>
      _ToDoListState(updateLocations: updateLocations, taskName: taskName);
}

class _ToDoListState extends State<ToDoList> {
  final Function updateLocations;
  final String taskName;

  _ToDoListState({required this.updateLocations, required this.taskName});

  final String baseUrl = 'http://localhost:6969/api';

  String username = myUser.getUsername();
  //String taskName = taskName;

  String token = myUser.getToken();

  List<dynamic> documents = [];
  List<String> itemNames = [];

  List<String> itemLocations = [];
  List<String> completedDocuments = [];

  Future<void> getDocs() async {
    final url = Uri.parse(
        '$baseUrl/user-service/todo-list/$taskName?username=$username');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as List<dynamic>;

      setState(() {
        documents = responseData;
        itemNames = [];
        itemLocations = [];

        for (final doc in documents) {
          if (doc['isDone:'] == 'pending') {
            itemNames.add(doc['DocName:']);
            itemLocations.add(doc['InstitutionLocation:']);
          } else {
            completedDocuments.add(doc['DocName:']);
            itemLocations.add(doc['InstitutionLocation:']);
          }
        }
      });
      itemStates = List<bool>.generate(documents.length, (index) => false);
    } else {
      throw Exception('Failed to load documents');
    }
  }

  Future<void> modifyDocumentStatus(String item, String status) async {
    final url = Uri.parse(
        '$baseUrl/user-service/updateDocument?userTaskName=$taskName&documentName=$item&status=$status&username=$username');

    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      print('Document status updated');
    } else {
      throw Exception('Failed to update document status');
    }
  }

  late List<bool> itemStates;

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  void toggleItemState(int index) {
    setState(() {
      itemStates[index] = !itemStates[index];
    });
  }

  bool _resp = false;

  void openGoogleMaps(List<String> locations) async {
    List<String> encodedLocations =
        locations.map((location) => Uri.encodeComponent(location)).toList();
    String destination = encodedLocations.removeLast();
    String waypoints = encodedLocations.join('|');
    String url =
        'https://www.google.com/maps/dir/?api=1&travelmode=driving&destination=$destination&waypoints=$waypoints';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 1000) {
      _resp = true;
    } else {
      _resp = false;
    }
    if (_resp) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0XFF101C2B),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'TO DO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 370.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF896F4E),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListView.builder(
                          itemCount: itemNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color(0XFF101C2B),
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        modifyDocumentStatus(
                                            itemNames[index], "done");
                                        final completedItem =
                                            itemNames.removeAt(index);
                                        completedDocuments.add(completedItem);
                                      });
                                    },
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                                title: Text(
                                  itemNames[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: itemStates[index],
                                  onChanged: (value) => toggleItemState(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                String finalLocation = "";
                                for (int i = 0; i < itemStates.length; i++) {
                                  if (itemStates[i] == true) {
                                    finalLocation =
                                        finalLocation + itemLocations[i];
                                    finalLocation = "$finalLocation;";
                                  }
                                }
                                _MyMapState().getDirections(finalLocation);
                                _MyMapState().build(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF896F4E),
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              child: const Text('Show route',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                List<String> locations = [];
                                for (int i = 0; i < itemStates.length; i++) {
                                  if (itemStates[i] == true) {
                                    locations.add(itemLocations[i]);
                                  }
                                }
                                openGoogleMaps(locations);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF896F4E),
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              child: const Text('Open Google Maps',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
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
          SizedBox(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0XFF101C2B),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Completed Documents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 370.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF896F4E),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListView.builder(
                          itemCount: completedDocuments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color(0XFF101C2B),
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        final item =
                                            completedDocuments.removeAt(index);
                                        itemNames.add(item);

                                        modifyDocumentStatus(item, "pending");
                                      });
                                    },
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                                title: Text(
                                  completedDocuments[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0XFF101C2B),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'TO DO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 370.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF896F4E),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListView.builder(
                          itemCount: itemNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color(0XFF101C2B),
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await modifyDocumentStatus(
                                          itemNames[index], "done");
                                      setState(() {
                                        final completedItem =
                                            itemNames.removeAt(index);
                                        completedDocuments.add(completedItem);
                                      });
                                    },
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                                title: Text(
                                  itemNames[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: itemStates[index],
                                  onChanged: (value) => toggleItemState(index),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                String finalLocation = "";
                                for (int i = 0; i < itemStates.length; i++) {
                                  if (itemStates[i] == true) {
                                    finalLocation =
                                        finalLocation + itemLocations[i];
                                    finalLocation = "$finalLocation;";
                                  }
                                }
                                updateLocations(finalLocation);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF896F4E),
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              child: const Text('Show route',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: ElevatedButton(
                              onPressed: () {
                                List<String> locations = [];
                                for (int i = 0; i < itemStates.length; i++) {
                                  if (itemStates[i] == true) {
                                    locations.add(itemLocations[i]);
                                  }
                                }
                                openGoogleMaps(locations);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF896F4E),
                                padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 15.0,
                                    bottom: 15.0),
                              ),
                              child: const Text('Open Google Maps',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
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
          SizedBox(
            width: 500.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0XFF101C2B),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Completed Documents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Container(
                        height: 370.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF896F4E),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListView.builder(
                          itemCount: completedDocuments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2,
                                    color: Color(0XFF101C2B),
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await modifyDocumentStatus(
                                          completedDocuments[index], "pending");
                                      setState(() {
                                        final item =
                                            completedDocuments.removeAt(index);
                                        itemNames.add(item);
                                      });
                                    },
                                    child: Icon(Icons.arrow_back),
                                  ),
                                ),
                                title: Text(
                                  completedDocuments[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
