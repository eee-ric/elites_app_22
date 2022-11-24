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
      body: SfPdfViewer.network(
        'https://firebasestorage.googleapis.com/v0/b/elites-app-22.appspot.com/o/Sadananda%202.pdf?alt=media&token=9ea6e6b2-acf9-4665-a191-d8c6258c1a79',
        key: _pdfViewerKey,
      ),
    );
  }
}
