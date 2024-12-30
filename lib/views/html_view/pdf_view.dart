import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:formula/utils/admob_helper.dart';

class PdfView extends StatefulWidget {
  const PdfView({super.key, required this.url});
  final String url;

  @override
  State<PdfView> createState() => _HomePage();
}

class _HomePage extends State<PdfView> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  AdmobHelper admobHelper = AdmobHelper();

  @override
  void initState() {
    print('Url : ${widget.url}');
    admobHelper.createInterstitialAd();
    Future.delayed(const Duration(seconds: 2), () {
      admobHelper.loadInterstitialAd();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PDF(
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: false,
                backgroundColor: Colors.grey,
                onPageChanged: (int? current, int? total) =>
                    _pageCountController.add('${current! + 1} - $total'),
                onViewCreated: (PDFViewController pdfViewController) async {
                  _pdfViewController.complete(pdfViewController);
                  final int currentPage =
                      await pdfViewController.getCurrentPage() ?? 0;
                  final int? pageCount = await pdfViewController.getPageCount();
                  _pageCountController.add('${currentPage + 1} - $pageCount');
                },
              ).cachedFromUrl(
                widget.url,
                placeholder: (double progress) =>
                    Center(child: Text('$progress %')),
                errorWidget: (dynamic error) =>
                    Center(child: Text(error.toString())),
              ),
            ),
            FutureBuilder<PDFViewController>(
                future: _pdfViewController.future,
                builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text("Total Pages: ${totalPageCount}"),
                        IconButton(
                          onPressed: () async {
                            final PDFViewController pdfController =
                                snapshot.data!;
                            final int currentPage =
                                (await pdfController.getCurrentPage())! - 1;
                            if (currentPage >= 0) {
                              await pdfController.setPage(currentPage);
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        StreamBuilder<String>(
                            stream: _pageCountController.stream,
                            builder: (_, AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: Text(snapshot.data!),
                                );
                              }
                              return const SizedBox();
                            }),
                        IconButton(
                          onPressed: () async {
                            final PDFViewController pdfController =
                                snapshot.data!;
                            final int currentPage =
                                (await pdfController.getCurrentPage())! + 1;
                            final int numberOfPages =
                                await pdfController.getPageCount() ?? 0;
                            if (numberOfPages > currentPage) {
                              await pdfController.setPage(currentPage);
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}
