import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Map extends StatefulWidget {
  final MapController mapController;

  const Map({super.key, required this.mapController});

  @override
  State<Map> createState() => _MapState();

  addMarker(GeoPoint point) async {
    await Future.delayed(const Duration(seconds: 10));
    await mapController.addMarker(point, angle: 0);
    await mapController.setMarkerIcon(point,
      const MarkerIcon(
        icon: Icon(
          Icons.location_on_rounded,
          color: Colors.red,
          size: 50,
        ),
      ),
    );
  }
}

class _MapState extends State<Map> {

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: widget.mapController,
      osmOption: OSMOption(
        enableRotationByGesture: false,
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: true,
        ),
        zoomOption: const ZoomOption(
          initZoom: 15,
          minZoomLevel: 12,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_2_rounded,
              color: Colors.blue,
              size: 90,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 90,
            ),
          ),
        ),
      ),
    );
  }
}
