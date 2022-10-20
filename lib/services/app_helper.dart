import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// width and height of screens
extension MediaQueryValues on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
// url lunch
Future<void>lunchUrl(url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch ${url}';
  }
}
// convert time stamp to date
String translateToDate(timestamp){
  var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd-MMM-yyyy').format(dt).toString();
}
// convert time stamp to full time
String translateToFullDate(timestamp){
  var dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var date = DateFormat('dd MMM').format(dt).toString();
  var time = DateFormat('HH:mm').format(dt).toString();
  return "$date at $time";
}
// loadingStyle
Widget loadingStyle(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(height: 10),
        CircularProgressIndicator(),
        SizedBox(height: 10),
        Text('Loading...'),
      ],
    ),
  );
}
// no Items
Widget noItems(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        Text('No items to show'),
        SizedBox(width: 5),
      ],
    ),
  );
}
// screenStartWidget
Widget screenStartWidget(BuildContext context,bool isLoading, {var items, required Widget buildWidget}) {
  return isLoading ? loadingStyle(context): items.isEmpty ? noItems(context) : buildWidget;
}