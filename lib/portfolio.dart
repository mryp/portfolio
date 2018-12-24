import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/emaxis.dart' as emaxis;
import 'package:portfolio/main.dart';

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
                decoration: InputDecoration(labelText: "フィルター"),
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
            ),
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PortfolioEditPage(codeList.values[i])),
            );
          },
        );
      },
    );
  }
}

class PortfolioEditPage extends StatefulWidget {
  final emaxis.CodeListValue editValue;

  PortfolioEditPage(this.editValue);

  @override
  State<StatefulWidget> createState() {
    return _PortfolioEditPageState();
  }
}

class _PortfolioEditPageState extends State<PortfolioEditPage> {
  final _nameController = TextEditingController();
  final _ratioController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.editValue.fundName;
  }

  void _showErrorDialog(String message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("入力エラー"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void savePortfolio() {
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new TopPage()),
        (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("銘柄設定"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "協会コード：" + widget.editValue.associationFundCd,
                style: TextStyle(fontSize: 18),
              ),
              Padding(padding: EdgeInsets.all(4)),
              Text("ファンド名：\n" + widget.editValue.fundName,
                  style: TextStyle(fontSize: 18)),
              Padding(padding: EdgeInsets.all(8)),
              TextField(
                decoration: InputDecoration(labelText: "表示名"),
                controller: _nameController,
              ),
              Padding(padding: EdgeInsets.all(4)),
              TextField(
                decoration: InputDecoration(labelText: "割合（％）"),
                keyboardType: TextInputType.number,
                controller: _ratioController,
              ),
              Padding(padding: EdgeInsets.all(4)),
              RaisedButton(
                child: Text("登録"),
                onPressed: () {
                  if (_nameController.text == "" ||
                      _ratioController.text == "") {
                    _showErrorDialog("未入力のデータが存在します");
                    return;
                  }
                  var ratio = int.tryParse(_ratioController.text);
                  if (ratio == null) {
                    _showErrorDialog("割合（％）の値は数値で入力してください");
                    return;
                  }
                  if (ratio < 0 || ratio > 100) {
                    _showErrorDialog("割合（％）の値は0 - 100 の範囲の数値を入力してください");
                    return;
                  }
                  savePortfolio();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
