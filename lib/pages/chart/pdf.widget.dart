import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewWidget extends StatelessWidget {
  const PdfViewWidget({super.key, required this.document});

  final Uint8List document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
      ),
      body: SfPdfViewer.memory(
        document,
      ),
    );
  }
}
