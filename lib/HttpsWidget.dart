import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpsWidget extends StatefulWidget {
  const HttpsWidget({super.key});

  @override
  State<HttpsWidget> createState() => _HttpsWidgetState();
}

class _HttpsWidgetState extends State<HttpsWidget> {

  List data = [];

  @override
  initState() {
    // _fetchData();
    _fetchDataHttp();
    super.initState();
  }

  _fetchData() async {
    final dio = Dio();
    try {
      final response = await dio.get('https://jsonplaceholder.typicode.com/users');
      print(response);
      setState(() {
        data = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchDataHttp() async {
    var url = Uri.https('jsonplaceholder.typicode.com', 'users');
    try {
      final response = await http.get(url);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      print(decodedResponse);
      setState(() {
        data = decodedResponse;
      });
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'This is an HTTPS API Response',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          data.length > 0 ?
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) => 
              ListTile(
                title: Text(data[index]['name']),
              ))
          : Container(),
      ],
    );
  }
}