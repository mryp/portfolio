import 'package:flutter/material.dart';
import 'package:portfolio/portfolio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: TopPage(),
    );
  }
}

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Portfolio"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('ダッシュボード'),
            onTap: () {
              //TODO: 未実装
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('ポートフォリオ変更'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PortfolioPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('購入・売却記録'),
            onTap: () {
              //TODO: 未実装
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('設定'),
            onTap: () {
              //TODO: 未実装
            },
          ),
        ],
      ),
    );
  }
}
