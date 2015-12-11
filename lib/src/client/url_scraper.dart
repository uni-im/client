import 'dart:io';
import 'dart:async';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class UrlScraper {
  Document _document;
  HttpClient _client;

  UrlScraper({HttpClient client}) {
    _client = client ?? new HttpClient();
  }

  String get title => _document.querySelector('title').text;

  /// fetch and parse the HTML from [url]
  Future scrape(String url) async {
    var req = await _client.getUrl(Uri.parse(url));
    HttpClientResponse response = await req.close();
    var bytes = await response
        .asyncExpand((bytes) => new Stream.fromIterable(bytes))
        .toList();

    _document = await parse(bytes, sourceUrl: url);
  }
}
