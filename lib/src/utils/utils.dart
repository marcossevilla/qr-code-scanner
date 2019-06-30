import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_scanner/src/providers/db_provider.dart';

import 'package:flutter/material.dart';

launchScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
    print('Geo');
  }
}
