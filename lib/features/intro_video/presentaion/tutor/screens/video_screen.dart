// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// class IntroVideoScreen extends StatefulWidget {
//   const IntroVideoScreen({Key? key}) : super(key: key);
//
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
//
// class _VideoAppState extends State<IntroVideoScreen> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//   bool isFullScreen = false;
//   bool isDisposed = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize();
//     _controller.play();
//     isDisposed = false;
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//     isDisposed = true;
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Listen for route changes
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       if (!isDisposed) {
//         Route? currentRoute = ModalRoute.of(context);
//         if (currentRoute == null) {
//           SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 VideoProgressIndicator(
//                   _controller,
//                   allowScrubbing: true,
//                   padding: EdgeInsets.zero,
//                   colors: VideoProgressColors(
//                     backgroundColor: Color(0xFF243771),
//                     playedColor: Colors.white,
//                     bufferedColor: Colors.grey,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: 10),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           _controller.value.isPlaying
//                               ? _controller.pause()
//                               : _controller.play();
//                         });
//                       },
//                       child: Icon(
//                         color: Colors.white,
//                         _controller.value.isPlaying
//                             ? Icons.pause
//                             : Icons.play_arrow,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     ValueListenableBuilder<VideoPlayerValue>(
//                       valueListenable: _controller,
//                       builder: (_, value, __) {
//                         return Text(
//                           "${formatDuration(value.position)} / ${formatDuration(value.duration)}",
//                           style: TextStyle(color: Colors.white),
//                         );
//                       },
//                     ),
//                     Spacer(),
//                     // Volume button
//                     InkWell(
//                       onTap: () {
//                         if (_controller.value.volume == 0.0) {
//                           _controller.setVolume(1.0);
//                         } else
//                           _controller.setVolume(0.0);
//                       },
//                       child: ValueListenableBuilder<VideoPlayerValue>(
//                         valueListenable: _controller,
//                         builder: (_, value, __) {
//                           return Icon(
//                             color: Colors.white,
//                             value.volume == 0.0
//                                 ? Icons.volume_off
//                                 : Icons.volume_up,
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     InkWell(
//                       onTap: toggleFullScreen,
//                       child: Icon(
//                         color: Colors.white,
//                         isFullScreen
//                             ? Icons.fullscreen_exit_rounded
//                             : Icons.fullscreen_rounded,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void toggleFullScreen() {
//     setState(() {
//       isFullScreen = !isFullScreen;
//       if (isFullScreen) {
//         SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
//       } else {
//         SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//       }
//     });
//   }
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$twoDigitMinutes:$twoDigitSeconds";
//   }
//
// }
