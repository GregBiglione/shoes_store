import 'package:flutter/material.dart';
import 'package:shoes_store/app/constant/constant.dart';
import 'package:shoes_store/widget/custom_dialog_box.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../ressource/color_manager.dart';

class CheckoutView extends StatefulWidget {
  final String url;

  const CheckoutView({super.key, required this.url});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  WebViewController controller = WebViewController();
  int count = 0;

  @override
  void initState() {
    controller
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress){},
            onWebResourceError: (error) {},
            onNavigationRequest: (request) {
              if(request.url.startsWith(widget.url)) {
                return NavigationDecision.prevent;
              }
              if(request.url.startsWith(successUrl)) {
                Navigator.pop(context, success);
              }
              else if(request.url.startsWith(cancelUrl)) {
                Navigator.of(context).popUntil((_) => count++ >= 2);
                customDialogBox(
                  cancelToastTitle,
                  Icons.cancel_outlined,
                  ColorManager.cancel,
                  context,
                );
              }

              return NavigationDecision.navigate;
              },
          ),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: WebViewWidget(controller: controller),
        )
    );
  }
}

