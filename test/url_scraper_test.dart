import 'package:test/test.dart';

import 'package:client/src/client/url_scraper.dart';

void main()
{
  group('URL Scraper', ()
  {
    UrlScraper scraper;

    setUp(()
    {
      scraper = new UrlScraper();
    });

    test('should get title "Example Domain" for example.com', ()
    {
      String url = 'http://example.com';
      scraper.getTitle(url).then(expectAsync((title) => expect(title, equals('Example Domain'))));
    });
  });
}
