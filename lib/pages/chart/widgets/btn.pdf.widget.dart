import 'package:flutter/material.dart';
import 'package:todo/pages/chart/report.list.widget.dart';

import '../../../theme/colors.dart';

class DownloadReportButton extends StatelessWidget {
  const DownloadReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: navBar,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportListWidget(),
            ))
      },
      icon: Icon(Icons.picture_as_pdf, color: Colors.black),
      label: Text(
        'View Reports',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
