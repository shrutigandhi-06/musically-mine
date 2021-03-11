import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class Authorization extends StatefulWidget {
  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen(
      (String url) async {
        if (mounted) {
          var res = await http.get(url);
          if (res.request.url.queryParameters['code'].isNotEmpty) {
            var code = res.request.url.queryParameters['code'];
            print('Authorization Code: ' + code);
            flutterWebviewPlugin.close();
            Navigator.pushNamed(context, '/questionnaire');
          }
          // if (res.statusCode != 200)
          //   throw Exception('http.get error: statusCode= ${res.statusCode}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: scaffoldKey,
      url:
          'https://accounts.spotify.com/authorize?client_id=5a9756f5bf2d45398a737632c8aa867b&response_type=code&redirect_uri=https://musically-mine.000webhostapp.com/index.php&scope=user-read-private%20user-read-email%20user-top-read&show_dialog=true',
      hidden: true,
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
