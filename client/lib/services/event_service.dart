import 'dart:convert';

import 'package:client/models/event_model.dart';
import 'package:http/http.dart' as http;

class EventService {
  static const _baseUrl = 'http://10.44.7.216:3000/api';

  Future<List<Event>> fetchPlaces() async {
    final response = await http.get(Uri.parse('$_baseUrl/places/today'));
    if (response.statusCode == 200) {
      Iterable decodedEvents = json.decode(response.body);

      List<Event> events = List<Event>.from(decodedEvents.map((event) => Event.fromJson(event)));
      return events;

    } else {
      throw Exception('Failed to load Events');
    }
  }
}