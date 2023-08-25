import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutView extends StatefulWidget {
  final String url;

  const CheckoutView({super.key, required this.url});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress){},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) {
          if(request.url.startsWith(widget.url)) {
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}

