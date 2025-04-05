import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myenglish/core/constants/app_images.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/common_widgets.dart';
import 'package:resize/resize.dart';

class ImagePickerSheet extends StatefulWidget {
  final Function(File?) uploadedFile;
  bool? isProfilePresented;
  ImagePickerSheet(
      {super.key,
      required this.uploadedFile,
      required this.isProfilePresented});

  @override
  State<ImagePickerSheet> createState() => _ImagePickerSheetState();
}

class _ImagePickerSheetState extends State<ImagePickerSheet> {
  File? file;

  void uploadImage(ImageSource source) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(source: source);
    if (image != null) {
      // final bytes = File(image.path).readAsBytesSync();
      print(image.path.split('/').last);
      file = File(image.path);
      // String fileDir = path.dirname(image.path);
      // String newPath = path.join(fileDir, 'newFileName.FileFormat');
      // file!.renameSync(newPath);
    }
    widget.uploadedFile(file);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Choose Profile Photo',
            textSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          vHeight(25.h),
          actionTile(AppImages.selectCamera, 'Camera',
              () => uploadImage(ImageSource.camera)),
          actionTile(AppImages.selectGallery, 'Gallery',
              () => uploadImage(ImageSource.gallery)),
          if (widget.isProfilePresented!) ...{
            vHeight(15.h),
            horizontalSeparatorWidget(),
            vHeight(15.h),
            actionTile(AppImages.removePhoto, 'Remove Photo', () {
              widget.uploadedFile(null);
              Navigator.pop(context);
            }),
          }
        ],
      ),
    );
  }

  Widget actionTile(String image, String text, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Image.asset(image),
            width(10.w),
            AppText(
              text,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
