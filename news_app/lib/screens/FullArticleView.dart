import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullArticleView extends StatefulWidget {

  final String url;
  FullArticleView(this.url);

  @override
  _FullArticleViewState createState() => _FullArticleViewState(url);
}

class _FullArticleViewState extends State<FullArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();

  final String _url;
  _FullArticleViewState(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
          ),
        ),
      );
  }
}
