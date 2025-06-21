// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class Name extends StatefulWidget {
//   const Name({super.key});

//   @override
//   State<Name> createState() => _NameState();
// }

// class _NameState extends State<Name> {
//   late VideoPlayerController _videoController;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.asset('assets/images/logiin.mp4')
//       ..initialize().then((_) {
//         setState(() {}); // Rebuild after initialization
//       })
//       ..setLooping(true)
//       ..play(); // Autoplay the video
//   }

//   @override
//   void dispose() {
//     _videoController.dispose(); // Release resources
//     super.dispose();
//   }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Center(
//         child: _videoController.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _videoController.value.aspectRatio,
//                 child: VideoPlayer(_videoController),
//               )
//             : CircularProgressIndicator(), // Show loading indicator
//       ),
//     ),
//   );
// }
// }
