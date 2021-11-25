import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Support extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body: WebView(
        initialUrl: "https://www.buymeacoffee.com/SchaffenSofts",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}