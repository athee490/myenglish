import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../course_deatils/data/models/get_tutor_single_course_details_model.dart';

class TutorIntroVideoScreen extends StatefulWidget {
  final TutorSingleCourseData tutorVideoUrl;
  const TutorIntroVideoScreen({super.key,required this.tutorVideoUrl});


  @override
  State<TutorIntroVideoScreen> createState() => _TutorIntroVideoScreenState();
}

class _TutorIntroVideoScreenState extends State<TutorIntroVideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.tutorVideoUrl.courseIntro.toString()));
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
