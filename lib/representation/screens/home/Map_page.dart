import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  bool _isMapReady = false;
  LatLng? _currentLocation;

  final LatLng _fallbackLocation = const LatLng(36.7525, 3.04197); // Default to Algiers, Algeria

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
      child: Card(
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildReportItem(
                      icon: Icons.car_crash,
                      label: 'Accident véhicule',
                      color: Colors.pink.shade100,
                      textColor: Colors.red.shade900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildReportItem(
                      icon: Icons.construction,
                      label: 'Travaux en cours',
                      color: Colors.orange.shade100,
                      textColor: Colors.orange.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildReportItem(
                      icon: Icons.traffic_sharp,
                      label: 'Violation feu',
                      color: Colors.purple.shade100,
                      textColor: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildReportItem(
                      icon: Icons.time_to_leave,
                      label: 'Embouteillage',
                      color: Colors.green.shade100,
                      textColor: Colors.green.shade900,
                    ),
                  ),
                ],
              ),
            ],
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

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);    

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   static const LatLng _pGooglePlex = LatLng(37.521563, -145.677433);
//   late GoogleMapController mapController;
//   bool _isMapReady = false;

//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//   }

//   Future<void> _requestLocationPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       setState(() {
//         _isMapReady = true;
//       });
//     }
//   }

//   Widget _buildReportCard() {
//     return Positioned(
//       top: 60,
//       left: 16,
//       right: 16,
//       child: Card(
//         elevation: 12,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildReportItem(
//                       icon: Icons.car_crash,
//                       label: 'Accident véhicule',
//                       color: Colors.pink.shade100,
//                       textColor: Colors.red.shade900,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildReportItem(
//                       icon: Icons.construction,
//                       label: 'Travaux en cours',
//                       color: Colors.orange.shade100,
//                       textColor: Colors.orange.shade900,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildReportItem(
//                       icon: Icons.traffic_sharp,
//                       label: 'Violation feu',
//                       color: Colors.purple.shade100,
//                       textColor: Colors.purple.shade900,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: _buildReportItem(
//                       icon: Icons.time_to_leave,
//                       label: 'Embouteillage',
//                       color: Colors.green.shade100,
//                       textColor: Colors.green.shade900,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildReportItem({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required Color textColor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: textColor, size: 20),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: textColor,
//                 fontSize: 11,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _isMapReady 
//             ? GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: _pGooglePlex,
//                   zoom: 14,
//                 ),
//                 onMapCreated: (GoogleMapController controller) {
//                   mapController = controller;
//                 },
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//               )
//             : const Center(
//                 child: CircularProgressIndicator(),
//               ),
//           if (_isMapReady) _buildReportCard(),
//         ],
//       ),
//     );
//   }
// }

