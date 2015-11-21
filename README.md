
[![Build Status][build_status_img]][build_status_url] [![Coverage Status][cover_status_img]][cover_status_url]

Uni-im/client is a web based chat application that allows users to send messages as collective groups using rich content. This includes sharing traditional textual messages as well as images, files, markdown, and more. It was created as part of a group project for the CSCI426 Advanced Programming course at the University of Montana.

The purpose of the project is to explore the inherit benefits of design patterns when creating applications. 

## Building

The application is written in [dart][dart_home] and requires the [Dart SDK][dart_download] to be run or compiled for distribution. Once you have a functional Dart SDK installation you can run an instance of the application by navigating to the root directory and starting a instance of the development server:

```pub serve web```

The default configuration of the application uses `http://localhost:8081` as the URI for the application [backend instance][chat_server]. If you do not have an instance available at this location the loopback transport will be used facilitating normal chat functionality without persisting any changes across sessions.

The development server will bind to [`http://localhost:8080`](http://localhost:8080) by default and the application will be available. Visiting this address in a browser will server the application for use.

### Tests

The application uses the [`test`][dart_test] package for testing. The test runner can be invoked with the following command at the root of the project directory:

```pub run test```

[chat_server]: https://github.com/uni-im/server-dart
[dart_home]: https://www.dartlang.org/
[dart_download]: https://www.dartlang.org/downloads/
[dart_test]: https://pub.dartlang.org/packages/test
[build_status_img]: https://travis-ci.org/uni-im/client.svg?branch=master
[build_status_url]: https://travis-ci.org/uni-im/client
[cover_status_img]: https://coveralls.io/repos/uni-im/client/badge.svg?branch=master&service=github
[cover_status_url]: https://coveralls.io/github/uni-im/client?branch=master
