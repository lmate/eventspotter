class Event {
  final String name;
  final double lat;
  final double lng;
  final String start;
  final String url;
  final String locationName;
  final String address;
  final String description;

  Event({
    required this.name,
    required this.lat,
    required this.lng,
    required this.start,
    required this.url,
    required this.locationName,
    required this.address,
    required this.description
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      lat: double.parse(json['lat']),
      lng: double.parse(json['lng']),
      start: json['start'],
      url: json['url'],
      locationName: json['location_name'],
      address: json['address'],
      description: json['description']
    );
  }
}
