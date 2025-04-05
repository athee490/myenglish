// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:myenglish/core/constants/app_colors.dart';
// import 'package:myenglish/core/constants/enums.dart';
// import 'package:myenglish/core/widgets/app_text.dart';
// import 'package:myenglish/di/di.dart';
// import 'package:myenglish/features/breakout_room/presentation/providers/breakout_room_provider.dart';
// import 'package:resize/resize.dart';
//
// class BreakoutRoomScreen extends ConsumerStatefulWidget {
//   final String channelId;
//   final String token;
//   const BreakoutRoomScreen(
//       {super.key, required this.channelId, required this.token});
//
//   @override
//   ConsumerState<BreakoutRoomScreen> createState() => _ClassRoomScreenState();
// }
//
// class _ClassRoomScreenState extends ConsumerState<BreakoutRoomScreen> {
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   init() async {
//     await ref
//         .read(breakoutRoomProvider)
//         .setupVideoSDKEngine(widget.channelId, widget.token);
//   }
//
//   // Build UI
//   @override
//   Widget build(BuildContext context) {
//     var mBreakoutroomProvider = ref.watch(breakoutRoomProvider);
//     print('21212121 ${mBreakoutroomProvider.breakoutRoomData.toJson()}');
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: MaterialApp(
//         home: Scaffold(
//           body: SafeArea(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                     height: 100.vh,
//                     width: 100.vw,
//                     color: AppColors.black,
//                     child: Center(child: _remoteVideo(mBreakoutroomProvider))),
//                 Positioned(
//                   right: 10.w,
//                   // bottom: 10.h,
//                   child: Container(
//                     height: 20.vh,
//                     decoration: BoxDecoration(
//                       color: AppColors.black,
//                       border: Border.all(),
//                     ),
//                     child: AspectRatio(
//                       aspectRatio: 9 / 16,
//                       child:
//                           Center(child: _localPreview(mBreakoutroomProvider)),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20.h,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       //end call option only for student
//                       if (getAppUser == AppUser.student)
//                         RawMaterialButton(
//                           onPressed: () => mBreakoutroomProvider.leave(),
//                           fillColor: AppColors.red,
//                           shape: const CircleBorder(),
//                           padding: const EdgeInsets.all(12),
//                           elevation: 5,
//                           child: Icon(
//                             Icons.call_end,
//                             color: AppColors.white,
//                             size: 35.h,
//                           ),
//                         ),
//                       RawMaterialButton(
//                         onPressed: () => mBreakoutroomProvider.mute(),
//                         fillColor: AppColors.white,
//                         shape: const CircleBorder(),
//                         padding: const EdgeInsets.all(12),
//                         elevation: 5,
//                         child: Icon(
//                           mBreakoutroomProvider.micMuted
//                               ? Icons.mic_off
//                               : Icons.mic,
//                           color: AppColors.primary,
//                           size: 25.h,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 //topic
//                 Positioned(
//                     bottom: 100.h,
//                     child: Container(
//                         height: 30.h,
//                         width: 100.vw,
//                         color: AppColors.black.withOpacity(0.5),
//                         child: Center(
//                           child: AppText(
//                             '${mBreakoutroomProvider.breakoutRoomData.topic}',
//                             textColor: AppColors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ))),
//                 Positioned(
//                     top: 20.h,
//                     left: 10,
//                     child: FittedBox(
//                         child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 2.5, horizontal: 10),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: AppColors.black.withOpacity(0.25)),
//                       child: AppText(
//                         '${mBreakoutroomProvider.timerDurtion.inMinutes.remainder(60).toString().padLeft(2, "0")}:${mBreakoutroomProvider.timerDurtion.inSeconds.remainder(60).toString().padLeft(2, "0")}',
//                         textSize: 12.sp,
//                         textColor: AppColors.white,
//                       ),
//                     ))),
//                 Positioned(
//                     top: 10.h,
//                     right: 10,
//                     child: IconButton(
//                       onPressed: () {
//                         mBreakoutroomProvider.getRoomUsers();
//                       },
//                       icon: Icon(
//                         Icons.info,
//                         color: AppColors.white,
//                         size: 30.h,
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// // Display local video preview
//   Widget _localPreview(BreakoutRoomProvider mClassroomProvider) {
//     if (mClassroomProvider.joined) {
//       return AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: mClassroomProvider.agoraEngine,
//           canvas: VideoCanvas(uid: mClassroomProvider.uid),
//         ),
//       );
//     } else {
//       return const AppText(
//         'Join a channel',
//         textColor: AppColors.white,
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
// // Display remote user's video
//   Widget _remoteVideo(BreakoutRoomProvider mClassroomProvider) {
//     if (mClassroomProvider.remoteUid.isNotEmpty) {
//       return Column(
//         children: mClassroomProvider.remoteUid
//             .map((e) => Expanded(
//                   child: AgoraVideoView(
//                     controller: VideoViewController.remote(
//                       rtcEngine: mClassroomProvider.agoraEngine,
//                       canvas: VideoCanvas(uid: e),
//                       connection: RtcConnection(
//                           channelId: mClassroomProvider.channelName),
//                     ),
//                   ),
//                 ))
//             .toList(),
//       );
//     } else {
//       String msg = '';
//       if (mClassroomProvider.joined) {
//         msg = 'Waiting for other users to Join';
//       }
//       return AppText(
//         msg,
//         textAlign: TextAlign.center,
//         textColor: AppColors.white,
//         fontWeight: FontWeight.w600,
//         textSize: 16.sp,
//       );
//     }
//   } // Clean up the resources when you leave
//
// }
