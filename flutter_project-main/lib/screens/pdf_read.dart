import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDF_Reader extends StatefulWidget {
  const PDF_Reader({super.key, required this.novel_url});
  static String id = 'welcome_screen';
  final String novel_url;
  @override
  State<PDF_Reader> createState() => _PDF_ReaderState();
}

class _PDF_ReaderState extends State<PDF_Reader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfPdfViewer.network(
            widget.novel_url,
            scrollDirection: PdfScrollDirection.horizontal,
            pageLayoutMode: PdfPageLayoutMode.single,
          ),
        ),
      ),
    );
  }
}
