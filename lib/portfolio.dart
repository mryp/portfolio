import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/emaxis.dart' as emaxis;

class PortfolioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PortfolioPageState();
  }
}

class _PortfolioPageState extends State<PortfolioPage> {
  var _listItems = ["test1", "test2", "test3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ポートフォリオ変更"),
      ),
      body: ListView.builder(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_listItems[index]}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PortfolioSelectPage()),
          );
        },
      ),
    );
  }
}

class PortfolioSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PortfolioSelectPageState();
  }
}

class _PortfolioSelectPageState extends State<PortfolioSelectPage> {
  final _emaxis = emaxis.EmaxisWebService();
  final _textController = TextEditingController();
  var _filterText = "";

  @override
  void initState() {
    super.initState();

    _filterText = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("追加銘柄選択"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: "再取得",
              onPressed: () async {
                await _emaxis.getFundCodeList(isReload: true);
                setState(() {}); //リロード
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: TextField(
                controller: _textController,
                onSubmitted: (text) {
                  _filterText = text;
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<emaxis.CodeList>(
                future: _emaxis.getFundCodeList(filterText: _filterText),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if (snapshot.hasData) {
                    return CodeListWidget(codeList: snapshot.data);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ));
  }
}

class CodeListWidget extends StatelessWidget {
  final emaxis.CodeList codeList;

  CodeListWidget({Key key, this.codeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: codeList.values.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(codeList.values[i].fundName),
        );
      },
    );
  }
}
