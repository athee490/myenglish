import 'dart:convert';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myenglish/core/utils/services/prefs.dart';

import '../../../main.dart';

bool checkNumeric(String? text) {
  if (text == null) return false;
  try {
    var value = num.tryParse(text);
    return true;
  } on FormatException {
    return false;
  }
}

extension ContextExtensions on BuildContext {
  bool get mounted {
    try {
      widget;
      return true;
    } catch (e) {
      return false;
    }
  }
}

var formatter = NumberFormat('#,##0');

bool checkNullOrEmptyString(String? s) {
  if (s == null) return true;
  if (s.trim().isEmpty) return true;
  return false;
}

bool checkNullOrEmptyList(List? s) {
  if (s == null) return true;
  if (s.isEmpty) return true;
  return false;
}

bool checkNull(dynamic s) {
  if (s == null) return true;
  return false;
}

///converts string from HH:mm:ss format to h:mm aa format
String timeToString(String? s) {
  String result = '';
  if (s == null) return result;
  List time = s.split(':');
  int hour = int.parse(time[0]);
  int min = int.parse(time[1]);
  if (hour > 11) {
    result += (hour - 12).toString();
  } else {
    result += hour.toString();
  }
  if (min != 0) {
    result += ':$min';
  }
  if (hour > 11) {
    result += ' pm';
  } else {
    result += ' am';
  }
  return result;
}

int differenceInDays(DateTime? from, DateTime? to) {
  if (from == null || to == null) return 0;
  return to.difference(from).inDays;
}

///Takes [url] and [key] and converts url to string and store in [Prefs] key
Future<void> urlToUInt8List(String url, String key) async {
  // print('url $url');
  bool isUrl = url.trim() != '';
  try {
    if (isUrl) {
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
          .buffer
          .asUint8List();
      await Prefs().setString(key, base64Encode(bytes));
    }
  } catch (e) {
    print('Image error $e');
  }
}

///Converts the given [dateTime] into a time ago string format
String timeAgoSinceDate(DateTime dateTime, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(dateTime);

  if (difference.inDays > 8) {
    return DateFormat("dd MMMM yyyy").format(dateTime);
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}

String formatYYYYMMDD(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

///capitalize first letter of word
String toTitleCase(String? input) {
  if (input == null || input.isEmpty) return '';
  return '${input[0].toUpperCase()}${input.substring(1).toLowerCase()}';
}

///convert ist time to utc time
String istToUtc(String? s) {
  return '';
}

Future<void> downloadPdf(String filePath) async {
  final permission = await FlDownloader.requestPermission();
  if (permission == StoragePermissionStatus.granted) {
    try {
      await FlDownloader.download(filePath);
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('PDF downloaded successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Failed to download PDF: $e'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  } else {
    debugPrint('Permission denied');
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      const SnackBar(
        content: Text('Permission denied'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
