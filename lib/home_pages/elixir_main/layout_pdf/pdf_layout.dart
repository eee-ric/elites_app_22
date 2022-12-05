import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdf_layout extends StatefulWidget {
  const pdf_layout({Key? key}) : super(key: key);

  @override
  State<pdf_layout> createState() => _pdf_layoutState();
}

class _pdf_layoutState extends State<pdf_layout> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.asset(
        'assets/pdf/sadananda_layout.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}
