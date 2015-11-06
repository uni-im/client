import 'dart:io';
import 'dart:async';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class UrlScraper
{
  Future<String> getTitle(String url) async
  {

    return _getHtml(url).then(
      (document) => document.querySelector('title').text
    );
  }

  /// fetch and parse the HTML from [url]
  Future<Document> _getHtml(String url) async => new HttpClient()
  .getUrl(Uri.parse(url))
  .then((req) => req.close())
  .then((res) => res
  .asyncExpand((bytes) => new Stream.fromIterable(bytes))
  .toList())
  .then((bytes) => parse(bytes, sourceUrl: url));
}
