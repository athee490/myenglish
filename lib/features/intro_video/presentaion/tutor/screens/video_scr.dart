import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../course_syllabus/data/models/student_selected_course_model.dart';

class IntroVideoScreen extends StatefulWidget {
  final SingleCourseDetails studentVideoUrl;
  const IntroVideoScreen({super.key,required this.studentVideoUrl,});


  @override
  State<IntroVideoScreen> createState() => _IntroVideoScreenState();
}

class _IntroVideoScreenState extends State<IntroVideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.studentVideoUrl.courseIntro.toString()));
    await videoPlayerController.initialize();
    setState(() {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController != null) {
      return Scaffold(
        body: Chewie(controller: chewieController!),
      );
    }
    return SizedBox();
  }
}
