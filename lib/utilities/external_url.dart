import 'package:url_launcher/url_launcher.dart';

class ExternalUrl {
  Future<void> launchNewUrl(url) async {
    final Uri updatedUrl = Uri.parse(url);
    if (!await launchUrl(updatedUrl)) {
      throw Exception('Could not launch $updatedUrl');
    }
  }
}
