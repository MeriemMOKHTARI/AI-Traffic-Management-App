import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);

  @override
  State<BusPage> createState() => BusState();
}

class BusState extends State<BusPage> {
  late GoogleMapController mapController;
  bool _isMapReady = false;
  LatLng? _currentLocation;

  final LatLng _fallbackLocation =
      const LatLng(36.7525, 3.04197); // Default to Algiers, Algeria

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    final locationPermission = await Permission.location.request();
    if (locationPermission.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _isMapReady = true;
        });
      } catch (e) {
        print("Error getting location: $e");
        // Fallback to the static location
        setState(() {
          _currentLocation = _fallbackLocation;
          _isMapReady = true;
        });
      }
    } else {
      // Handle permission denied, fallback to static location
      print("Location permission denied");
      setState(() {
        _currentLocation = _fallbackLocation;
        _isMapReady = true;
      });
    }
  }

  Widget _buildReportCard() {
    return Positioned(
      top: 60,
      left: 16,
      right: 16,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: 
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric (horizontal: 8),
                child: TextField(               
                  decoration: InputDecoration(
                    hintText: 'Saisissez votre destination...',
                    hintStyle: TextStyle(color: AppColors.primary.withOpacity(0.5)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildReportItem({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_currentLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _fallbackLocation,
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          if (_isMapReady) _buildReportCard(),
        ],
      ),
    );
  }
}
