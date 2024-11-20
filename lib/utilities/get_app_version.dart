import 'package:package_info_plus/package_info_plus.dart';

Future<String> getAppVersion() async {
  // Fetch the package information
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // Get the version and build number
  String buildNumber = packageInfo.buildNumber; // e.g., "1.0.0"
  return buildNumber;
}
