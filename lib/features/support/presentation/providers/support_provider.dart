import 'package:flutter/material.dart';
import 'package:myenglish/core/widgets/toast.dart';
import 'package:myenglish/features/support/presentation/models/faq_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportProvider extends ChangeNotifier {
  ///TODO: Actual data not provided yet
  String emailAddress = 'ramassergroup@gmail.com';
  String contactNumber = '+1 316-882-7967';
  List<FaqModel> faq = [
    FaqModel(
        question: 'Who can take a class ?',
        answer:
            'Someone who\'s truly experienced in their domain would be able to load a class. Students will be able to review the class and if the class does not meet the standard of the uploaded syllabus, the trainer can be banned from the platform.'),
    FaqModel(
        question: 'How does the platform charge ?',
        answer:
            'Potential students will pay a monthly subscription to take a class. The platform would charge the instructors some percentage before pay out.'),
    FaqModel(
        question: 'Are the classes recorded ?',
        answer:
            'Yes, the classes are recorded and they can be accessed only from the app.'),
  ];

  onTapFaq(int index) {
    faq[index].isExpanded = !faq[index].isExpanded;
    notifyListeners();
  }

  call() async {
    var url = Uri.parse("tel:$contactNumber");
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {
      showToast('Could not open dialler');
    }
  }

  sendEmail() async {
    var url = Uri.parse('mailto:$emailAddress');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {
      showToast('Could not open mail app');
    }
  }
}
