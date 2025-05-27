import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class HttpWidget extends StatefulWidget {
  const HttpWidget({super.key});

  @override
  State<HttpWidget> createState() => _HttpWidgetState();
}

class _HttpWidgetState extends State<HttpWidget> {

  String message = "";
  List endPoints = [];

  @override
  initState() {
    // _fetchData();
    _fetchDataHttp();
    super.initState();
  }

  _fetchData() async {
    final dio = Dio();
    try {
      final response = await dio.get('http://192.168.2.97:3000');
      print(response);
      setState(() {
        message = response.data["message"];
        endPoints = response.data["availableEndpoints"];
      });
    } catch (e) {
      print(e);
    }
  }

  _fetchDataHttp() async {
    var url = Uri.http('192.168.2.97:3000');
    try {
      final response = await http.get(url);
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(decodedResponse);
      setState(() {
        message = decodedResponse["message"];
        endPoints = decodedResponse["availableEndpoints"];
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
            'This is an HTTP API Response',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          endPoints.length > 0 ?
          ListView.builder(
            shrinkWrap: true,
            itemCount: endPoints.length,
            itemBuilder: (context, index) => ListTile(title: Text(endPoints[index]))): Container(),
      ],
    );
  }
}