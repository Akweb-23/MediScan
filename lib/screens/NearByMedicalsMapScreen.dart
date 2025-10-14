import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NearbyMedicalsMapScreen extends StatefulWidget {
  const NearbyMedicalsMapScreen({super.key});

  @override
  State<NearbyMedicalsMapScreen> createState() => _NearbyMedicalsMapScreenState();
}

class _NearbyMedicalsMapScreenState extends State<NearbyMedicalsMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _addNearbyMarkers(); // add sample markers
    });
  }

  void _addNearbyMarkers() {
    // Sample nearby medical locations (lat, lng)
    final nearbyMedicals = [
      {"name": "Pharmacy A", "lat": _currentPosition!.latitude + 0.001, "lng": _currentPosition!.longitude + 0.001},
      {"name": "Clinic B", "lat": _currentPosition!.latitude - 0.001, "lng": _currentPosition!.longitude - 0.001},
      {"name": "Hospital C", "lat": _currentPosition!.latitude + 0.002, "lng": _currentPosition!.longitude - 0.0015},
    ];

    for (var m in nearbyMedicals) {
      _markers.add(Marker(
        markerId: MarkerId(m["name"].toString()),
        position: LatLng(m["lat"] as double, m["lng"] as double),
        infoWindow: InfoWindow(title: m["name"].toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearby Medicals")),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 15,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
