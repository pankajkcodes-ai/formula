import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formula/res/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFormulaPage extends StatefulWidget {
  const WebViewFormulaPage({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<WebViewFormulaPage> createState() => _WebViewFormulaPageState();
}

class _WebViewFormulaPageState extends State<WebViewFormulaPage> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    if (kDebugMode) {
      print("Url : ${widget.url}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Resources.dimens.height(context) * 0.08,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
