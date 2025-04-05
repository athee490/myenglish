import 'package:flutter/material.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/features/resources/domain/usecase/document_resource_usecase.dart';
import 'package:myenglish/features/resources/domain/usecase/video_resource_usecase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../../home/domain/usecase/student_dashboard_usecase.dart';

class ResourcesProvider extends ChangeNotifier {
  // final StudentDashboardUseCase _studentDashboardUseCase;
  final DocumentResourceUseCase _documentResourceUseCase;
  final VideoResourceUseCase _videoResourceUseCase;

  ResourcesProvider(
    // this._studentDashboardUseCase,
    this._documentResourceUseCase,
    this._videoResourceUseCase,
  ) {
    documentScrollController.addListener(() {
      if (documentScrollController.position.maxScrollExtent ==
              documentScrollController.position.pixels &&
          docCurrentPage < docTotalPage) {
        print(
            'pageno: $docCurrentPage list length: ${documentList.length} total: $docTotalPage');
        docCurrentPage += 1;
        getDocuments();
      }
      documentScrollController.position.isScrollingNotifier.addListener(() {});
    });
    videoScrollController.addListener(() {
      videoScrollController.addListener(() {
        if (videoScrollController.position.maxScrollExtent ==
                videoScrollController.position.pixels &&
            videoCurrentPage < videoTotalPage) {
          print(
              'pageno: $videoCurrentPage list length: ${videoList.length} total: $videoTotalPage');
          videoCurrentPage += 1;
          getVideos();
        }
        videoScrollController.position.isScrollingNotifier.addListener(() {});
      });
    });
  }

  bool isLoading = true;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  final ScrollController documentScrollController = ScrollController();
  final ScrollController videoScrollController = ScrollController();
  int videoTotalPage = 1, videoCurrentPage = 1;
  int docTotalPage = 1, docCurrentPage = 1;
  bool paginationLoading = false;
  bool paid = Prefs().getBool(Prefs.isPaidForResources);
  bool tutorVerified = Prefs().getBool(Prefs.tutorVerified);
  CourseLevel courseLevel = Prefs().getString(Prefs.courseLevel) == 'student'
      ? CourseLevel.student
      : CourseLevel.professional;

  List<ResourceDatum> videoList = [];
  List<ResourceDatum> documentList = [];
  ResourceFilter languageFilter = ResourceFilter.All;

  bool accountSuspended = false;

  // Future<void> getDashboard() async {
  //   setLoader(true);
  //   var data = await _studentDashboardUseCase.call();
  //   setLoader(false);
  //   if (data.isLeft()) {
  //     print('212121 data ${data.getLeft().error.toString()}');
  //     if (data.getLeft().error.toString().toLowerCase().contains('suspended')) {
  //       accountSuspended = true;
  //       notifyListeners();
  //     } else {
  //       showToast(data.getLeft().error, type: ToastType.error);
  //     }
  //   } else {
  //     accountSuspended = false;
  //     getDocuments();
  //     getVideos();
  //   }
  // }

  Future<void> getVideos() async {
    setLoader(true);
    if (videoCurrentPage != 1) loadPagination(true);
    var data = await _videoResourceUseCase.call(
        courseLevel, videoCurrentPage, languageFilter.name.toLowerCase());
    setLoader(false);
    print('212121 data $data');
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      videoTotalPage = data.getRight().totalCount?.totalPages ?? 1;
      List<ResourceDatum> tempList = data.getRight().data ?? [];
      tempList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      for (var element in tempList) {
        var controller = VideoPlayerController.network(element.file!);
        controller.initialize();
        element.videoPlayerController = controller;
      }
      videoList.addAll(tempList);
    }
    if (videoCurrentPage != 1) loadPagination(false);
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () => setState());
  }

  Future<void> getDocuments() async {
    setLoader(true);
    if (docCurrentPage != 1) loadPagination(true);
    var data = await _documentResourceUseCase.call(courseLevel, docCurrentPage);
    setLoader(false);
    print('212121 data $data');
    if (data.isLeft()) {
      showToast(data.getLeft().error, type: ToastType.error);
    } else {
      docTotalPage = data.getRight().totalCount?.totalPages ?? 1;
      List<ResourceDatum> tempList = data.getRight().data ?? [];
      tempList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      documentList.addAll(tempList);
    }
    if (docCurrentPage != 1) loadPagination(false);
    notifyListeners();
  }

  loadPagination(bool value) {
    paginationLoading = value;
    notifyListeners();
  }

  updateLanguageFilter(ResourceFilter filter) {
    if (filter != languageFilter) {
      languageFilter = filter;
      videoList = [];
      getVideos();
      notifyListeners();
    }
  }

  updateCourseLevel(String level) {
    courseLevel = CourseLevel.values
        .where((element) => element.name.toLowerCase() == level.toLowerCase())
        .first;
    documentList = [];
    getDocuments();
    videoList = [];
    getVideos();
  }

  Future<VideoPlayerController> initController(String url) async {
    var controller = VideoPlayerController.network(url);
    controller.initialize();
    return controller;
  }

  void playPause(ResourceDatum resource) {
    // print(controller.value.isPlaying);
    for (var element in videoList) {
      if (element == resource) {
        var controller = element.videoPlayerController!;
        controller.value.isPlaying ? controller.pause() : controller.play();
      } else if (element.videoPlayerController != null &&
          element.videoPlayerController!.value.isPlaying) {
        element.videoPlayerController!.pause();
      }
    }
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  redirectVideo(String uri) async {
    var url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }
}
