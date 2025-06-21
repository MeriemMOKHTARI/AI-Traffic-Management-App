import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Aboutus.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Buses_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Map_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Report_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/SosPage.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/alerts_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/guide_page.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/widgets/drawer.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomIndex = 2;

  final List<Widget> _pages = [
    const BusPage(),
    AlertsPage(),
    const MapPage(),
    const ReportScreen(),
    GuideScreen(),
  ];

  final List<BottomNavigationBarItem> _navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.directions_bus_outlined),
      label: 'Buses',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.warning_outlined),
      label: 'Alertes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.map_outlined),
      label: 'Map',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.description_outlined),
      label: 'Rapports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      label: 'Guide',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.2),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                'assets/images/saferoad.png',
                height: 150,
                width: 150,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () { Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  SosScreen(),
              ),
            ); },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                width: 35,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF4444),
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _bottomIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: _navigationItems,
          currentIndex: _bottomIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color(0xFF9DB2CE),
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          elevation: 0,
          onTap: (index) {
            setState(() {
              _bottomIndex = index;
            });
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';
// import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Buses_page.dart';
// import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Map_page.dart';
// import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/Report_page.dart';
// import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/alerts_page.dart';
// import 'package:happy_tech_mastering_api_with_flutter/representation/screens/home/profile_screen.dart';

// class RootPage extends StatefulWidget {
//   const RootPage({super.key});

//   @override
//   State<RootPage> createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   int _bottomIndex = 2; 

//   final List<Widget> _pages = [
//     const BusPage(),
//     AlertsPage(),
//     const MapPage(),
//     const Report(),
//     const ProfileScreen(),
//   ];

//   final List<BottomNavigationBarItem> _navigationItems = [
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.directions_bus_outlined),
//       label: 'Buses',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.warning_outlined),
//       label: 'Alertes',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.map_outlined),
//       label: 'Map',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.description_outlined),
//       label: 'Rapports',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.person_outline),
//       label: 'Profile',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         shadowColor: Colors.grey.withOpacity(0.2),
//         leading: IconButton(
//           icon:  Icon(
//             Icons.menu,
//             color: AppColors.primary,
//             size: 24,
//           ),
//           onPressed: () {
//             // Add menu functionality here
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Image.asset(
//                 'assets/images/saferoad.png', 
//                 height: 150,
//                 width: 150,
//               ),
//             ),
            
//           ],
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Container(
//               width: 35,
//               height: 40,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xFFFF4444),
//               ),
//               child: const Center(
//                 child: Text(
//                   'SOS',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//       body: IndexedStack(
//         index: _bottomIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border(
//             top: BorderSide(
//               color: Colors.grey.withOpacity(0.2),
//               width: 1,
//             ),
//           ),
//         ),
//         child: BottomNavigationBar(
//           items: _navigationItems,
//           currentIndex: _bottomIndex,
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: Color(0xFF9DB2CE),
//           backgroundColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           selectedFontSize: 12,
//           unselectedFontSize: 12,
//           showUnselectedLabels: true,
//           elevation: 0,
//           onTap: (index) {
//             setState(() {
//               _bottomIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
