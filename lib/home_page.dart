import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PdfControllerPinch pdfControllerPinch;

  int totalPageCount = 0, currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset(
        'assets/pdf/ChannelsFail.pdf',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Viewer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Space out the widgets
        children: [
          _pdfView(), // PDF View takes up most of the screen
          _buildBottomNavigation(), // Page indicators at the bottom
        ],
      ),
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Pages: $totalPageCount",
              style: const  TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                  duration: const  Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              "Current Page: $currentPage",
              style:const  TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
