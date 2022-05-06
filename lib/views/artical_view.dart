import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticaleView extends StatefulWidget{

  final String blogurl;
  ArticaleView({required this.blogurl});

  @override
  ArticaleViewState createState() => ArticaleViewState();
}
class ArticaleViewState extends State<ArticaleView>{
  final Completer<WebViewController> _completer = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News'),
            Text('App', style: TextStyle(
                color: Colors.blue
            ),)
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
              Icon(Icons.save),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0.3,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:  WebView(
          initialUrl: widget.blogurl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);

          }),
        ),
    )

    );
  }


}