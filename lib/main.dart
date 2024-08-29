import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Web API Fetch Example Hyuk'),
        ),
        body: Center(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = 'Press the button to fetch data';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_data),
        ElevatedButton(
          onPressed: () async {
            try {
              final result = await fetchData();
              setState(() {
                _data = result;
              });
            } catch (e) {
              setState(() {
                _data = 'Failed to load data: $e';
              });
            }
          },
          child: Text('Fetch Data'),
        ),
      ],
    );
  }

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('https://us-central1-no-money-no-honey-okay.cloudfunctions.net/api/hello'));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      return decoded['message'];  // Access the message key from JSON
    } else {
      throw Exception('Failed to load data');
    }
  }

}

