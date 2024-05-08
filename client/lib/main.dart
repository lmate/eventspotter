import 'package:client/eventlist.dart';
import 'package:client/models/event_model.dart';
import 'package:client/services/event_service.dart';
import 'package:client/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Event> _events = List.empty();
  final EventService _eventService = EventService();
  static final _mapController = MapController.withPosition(
    initPosition: GeoPoint(
      latitude: 47.4358055,
      longitude: 8.4737324,
    ),
  );
  final Map _map = Map(mapController: _mapController);

  void centerMapAtLocation(double latitude, double longitude) {
    _mapController.moveTo(GeoPoint(latitude: latitude, longitude: longitude), animate: true,);
    _mapController.zoomIn();
  }

  void getTodaysEvents() async {
    print('event1');
    List<Event> events = await _eventService.fetchPlaces();
    print('event2');
    setState(() {
      _events = events;
      print('events:');
      print(events);
    });
    showEventsOnMap();
  }

  void showEventsOnMap() async {
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].lat != 0 && _events[i].lng != 0) {
        _map.addMarker(
            GeoPoint(latitude: _events[i].lat, longitude: _events[i].lng));
      }
    }
  }

  @override
  void initState() {
    print('init');
    super.initState();
    getTodaysEvents();
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
        drawer: Drawer(
            child: EventList(
          events: _events,
          onEventSelected: (event) {
            centerMapAtLocation(event.lat, event.lng);
          },
        )),
        body: _map,
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton.extended(
            onPressed: () {
              Scaffold.of(context).openDrawer();                
            },
            icon: const Icon(Icons.menu),
            label: const Text('Show Events'),
          ),
        ),
      ),
    );
  }
}
