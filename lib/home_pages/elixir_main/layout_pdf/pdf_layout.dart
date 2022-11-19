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
        'https://firebasestorage.googleapis.com/v0/b/elites-app-22.appspot.com/o/layout_pdf%2FSadananda.pdf?alt=media&token=eea430ed-1832-4a31-8388-6eb709b69c08',
        key: _pdfViewerKey,
      ),
    );
  }
}
