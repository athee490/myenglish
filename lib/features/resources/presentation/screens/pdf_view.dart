import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:myenglish/core/constants/app_colors.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/widgets/app_text.dart';
import 'package:myenglish/core/widgets/appbar.dart';

class PdfView extends StatelessWidget {
  final String title;
  final String url;
  const PdfView({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: toTitleCase(title)),
            Expanded(
              child: const PDF().cachedFromUrl(
                url,
                placeholder: (progress) =>
                    Center(child: AppText('$progress %')),
                errorWidget: (error) => Center(
                    child: AppText(
                  error.toString(),
                  textColor: AppColors.black,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
