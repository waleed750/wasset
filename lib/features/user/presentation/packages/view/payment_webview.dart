import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// The widget that shows the 3DS step.
class ThreeDSWebView extends StatefulWidget {
  const ThreeDSWebView({
    super.key,
    required this.transactionUrl,
    required this.on3dsDone,
    required this.callbackUri,
  });
  final String transactionUrl;
  final Function on3dsDone;
  final Uri callbackUri;

  @override
  State<ThreeDSWebView> createState() => _ThreeDSWebViewState();
}

class _ThreeDSWebViewState extends State<ThreeDSWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    initWebViewController();
  }

  void initWebViewController() {
    final controller = WebViewController()
      ..loadRequest(Uri.parse(widget.transactionUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (pageUrl) {
            final redirectedTo = Uri.parse(pageUrl);

            final hasReachedFinalRedirection =
                redirectedTo.host == widget.callbackUri.host;

            if (hasReachedFinalRedirection) {
              final queryParams = redirectedTo.queryParameters;

              final status = queryParams['status'] ?? '';
              final message = queryParams['message'] ?? '';

              widget.on3dsDone(status, message);
            }
          },
        ),
      );

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: WidgetsBinding
              .instance.platformDispatcher.views.first.physicalSize.height,
          width: WidgetsBinding
              .instance.platformDispatcher.views.first.physicalSize.width,
          child: WebViewWidget(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
