import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MapController _mapController = MapController();
  LatLng _currentPosition = LatLng(-7.424563, 109.239637); // Telkom University Purwokerto
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _addMarker(_currentPosition, "Telkom University Purwokerto");
  }

  // Mendapatkan lokasi pengguna dengan penanganan error
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Layanan lokasi tidak aktif")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Izin lokasi ditolak secara permanen")),
          );
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _mapController.move(_currentPosition, 15.0);
        _addMarker(_currentPosition, "Lokasi Saya");
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mendapatkan lokasi: $e")),
      );
    }
  }

  // Menambahkan marker di peta
  void _addMarker(LatLng position, String title) {
    setState(() {
      _markers.add(
        Marker(
          point: position,
          width: 40.0,
          height: 40.0,
          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("OpenStreetMap - Telkom University Purwokerto"),
          backgroundColor: Colors.green,
        ),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _currentPosition, // Menggunakan initialCenter
            initialZoom: 16.0, // Menggunakan initialZoom
            onTap: (tapPosition, latLng) => _addMarker(latLng, "Lokasi Dipilih"),
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: _markers,
            ),
            CurrentLocationLayer(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: _getCurrentLocation,
        ),
      ),
    );
  }
}
