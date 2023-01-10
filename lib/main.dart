import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:meta/meta.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

extension GetOnuri on Object {
  Future<HttpClientResponse> getUrl(String url) => HttpClient()
      .getUrl(
        Uri.parse(url),
      )
      .then((req) => req.close());
}

mixin CanMakeGetCall {
  String get url;
  @useResult
  Future<String> getString() => getUrl(
        url,
      ).then(
        (resp) => resp
            .transform(
              utf8.decoder,
            )
            .join(),
      );
}

@immutable
class GetPeople with CanMakeGetCall {
  const GetPeople();
  @override
  String get url => 'http://127.0.0.1:5500/apis/people.json';
}

void testIt() async {
  final people = await const GetPeople().getString();
  people.log();
}

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testIt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
