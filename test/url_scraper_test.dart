import 'dart:async';

import 'package:test/test.dart';

import 'package:client/src/client/url_scraper.dart';

void main() {
  group('URL Scraper', () {
    UrlScraper scraper;

    setUp(() {
      scraper = new UrlScraper();
    });

    test('should get title "Example Domain" for example.com', () async {
      await scraper.scrape('http://example.com');
      expect(scraper.title, equals('Example Domain'));
    });
  });
}
