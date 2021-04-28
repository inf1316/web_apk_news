import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  String _filename;
  Dio _dio = new Dio();

  @override
  void initState() {
    super.initState();

    _requestTweet();
  }

  @override
  Widget build(BuildContext context) {
    var child;
    if (_tweetHTML != null && _tweetHTML.length > 0) {
      final downloadUrl = Uri.file(_filename).toString();

      final webView = WebView(
          initialUrl: downloadUrl, javascriptMode: JavascriptMode.unrestricted);

      final box = LimitedBox(
        maxHeight: 300.0,
        child: webView,
      );
      child = box;
    } else {
      child = Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(child: child);
  }

  void _requestTweet() async {
    String tweetUrl = widget.tweetUrl;
    String tweetID;

    if (tweetUrl == null || tweetUrl.isEmpty) {
      if (widget.tweetID == null || widget.tweetID.isEmpty) {
        throw new ArgumentError('Missing tweetUrl or tweetID property.');
      }
      tweetUrl = _formTweetURL(widget.tweetID);
      tweetID = widget.tweetID;
    }

    if (tweetID == null) {
      tweetID = _tweetIDFromUrl(tweetUrl);
    }

    // Example: https://publish.twitter.com/oembed?url=https://twitter.com/Interior/status/463440424141459456
    final downloadUrl = "https://publish.twitter.com/oembed?url=$tweetUrl";
    print("TweetWebView._requestTweet: $downloadUrl");

    final jsonString = await _loadTweet(downloadUrl);
    final html = _parseTweet(jsonString);

    if (html != null) {
      final filename = await _saveTweetToFile(tweetID, html);
      setState(() {
        _tweetHTML = html;
        _filename = filename;
      });
    }
  }

  Future<String> _saveTweetToFile(String tweetID, String html) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final filename = '$tempPath/tweet-$tweetID.html';
    File(filename).writeAsString(html);
    return filename;
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

  String _formTweetURL(String tweetID) {
    return "https://twitter.com/Interior/status/$tweetID";
  }

  String _tweetIDFromUrl(String tweetUrl) {
    final uri = Uri.parse(tweetUrl);
    if (uri.pathSegments.length > 0) {
      return uri.pathSegments[uri.pathSegments.length - 1];
    }
    return null;
  }

  Future<String> _loadTweet(String tweetUrl) async {
    Response result = await _downloadTweet(tweetUrl);
    return json.encode(result.data);
  }

  Future<Response> _downloadTweet(String tweetUrl) {
    return _dio.get(tweetUrl);
  }
}
