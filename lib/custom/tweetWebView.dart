import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TweetWebView extends StatefulWidget {
  final String tweetUrl;

  final String tweetID;

  TweetWebView({this.tweetUrl, this.tweetID});

  TweetWebView.tweetID(String tweetID)
      : this.tweetID = tweetID,
        this.tweetUrl = null;
  TweetWebView.tweetUrl(String tweetUrl)
      : this.tweetUrl = tweetUrl,
        this.tweetID = null;

  @override
  _TweetWebViewState createState() => new _TweetWebViewState();
}

class _TweetWebViewState extends State<TweetWebView> {
  String _tweetHTML;

  Dio _dio = new Dio();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _requestTweet();
  }

  @override
  Widget build(BuildContext context) {
    var child;
    if (_tweetHTML != null && _tweetHTML.length > 0) {
      final downloadUrl = Uri.dataFromString(_tweetHTML,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString();

      final webView = new WebviewScaffold(
        url: "https://www.google.com",
      );

      final box = Expanded(
          child: LimitedBox(
        maxHeight: 250.0,
        child: webView,
      ));

      child = Center(
        child: box,
      );
    } else {
      child = Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(child: child);
  }

  void _requestTweet() async {
    String tweetUrl = widget.tweetUrl;

    if (tweetUrl == null || tweetUrl.isEmpty) {
      if (widget.tweetID == null || widget.tweetID.isEmpty) {
        throw new ArgumentError('Missing tweetUrl or tweetID property.');
      }
    }

    // Example: https://publish.twitter.com/oembed?url=https://twitter.com/Interior/status/463440424141459456
    final downloadUrl = "https://publish.twitter.com/oembed?url=$tweetUrl";
    print("TweetWebView._requestTweet: $downloadUrl");

    final jsonString = await _loadTweet(downloadUrl);
    final html = _parseTweet(jsonString);

    if (html != null) {
      setState(() {
        _tweetHTML = html;
      });
    }
  }

  String _parseTweet(String jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      print('TweetWebView._parseTweet: empty jsonString');
      return null;
    }

    var item;
    try {
      item = json.decode(jsonString);
    } catch (e) {
      print(e);
      print('error parsing tweet json: $jsonString');
      return '<p>error loading tweet</p>';
    }

    final String html = item['html'];

    if (html == null || html.isEmpty) {
      print('TweetWebView._parseTweet: empty html');
    }
    return html;
  }

  Future<String> _loadTweet(String tweetUrl) async {
    Response result = await _downloadTweet(tweetUrl);
    return json.encode(result.data);
  }

  Future<Response> _downloadTweet(String tweetUrl) {
    return _dio.get(tweetUrl);
  }
}
