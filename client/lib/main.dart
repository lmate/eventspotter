import 'package:client/models/event_model.dart';
import 'package:client/services/event_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(47.497913, 19.040236);
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  List<Event> _events = List.empty();
  final EventService _eventService = EventService();

  void getTodaysEvents() async {
    List<Event> events = await _eventService.fetchPlaces();
    setState(() {
      _events = events;
    });
    showEventsOnMap();
  }

  void showEventsOnMap() {
    for (int i = 0; i < _events.length; i++) {
      MarkerId markerId = MarkerId(i.toString());
      _markers[markerId] = Marker(
        markerId: markerId,
        position: LatLng(_events[i].lat, _events[i].lng),
        infoWindow: InfoWindow(title: _events[i].name, snippet: ''),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getTodaysEvents();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    /*setState(() {
      MarkerId markerId = const MarkerId('0');
      _markers[markerId] = Marker(
        markerId: markerId,
        position: const LatLng(45.521563, -122.677433),
        infoWindow: const InfoWindow(title: 'Portland', snippet: '*'),
      );
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            markers: Set<Marker>.of(_markers.values)),
      ),
    );
  }
}
