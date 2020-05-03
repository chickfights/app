import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './quote.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Future<List<Quote>> getData() async {
    List<Quote> list;
    String link = "https://raw.githubusercontent.com/trickdev/qdb/master/quotes.json";
    var res = await http.get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

    if(res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data as List;
      rest.shuffle();
      list = rest.map<Quote>((json) => Quote.fromJson(json)).toList();
    }

    return list;
  }

  Widget listView(List<Quote> quote) {
    return Container(
      child: ListView.builder(
          itemCount: quote.length,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                leading: Text('${quote[position].id}', style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('${quote[position].quote}'),
              ),
            );
          }),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        return snapshot.data != null ? listView(snapshot.data) : Center(child: CircularProgressIndicator());
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chickfights"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildBody(),
          )
        ],
      )
    );
  }
}
