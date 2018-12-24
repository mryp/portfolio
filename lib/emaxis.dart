import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:portfolio/utils.dart';

class EmaxisWebService {
  final _fundApiHost = "https://developer.am.mufg.jp";
  var _cacheFundCodeJson = "";

  Future<String> get _homeDocumentsPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _fundCodeFile async {
    final path = await _homeDocumentsPath;
    return File("$path/code_list.json");
  }

  CodeList parseFundCodeJson(String jsonText) {
    final jsonResponse = json.decode(jsonText);
    final codeList = CodeList.fromJson(jsonResponse);
    return codeList;
  }

  Future<CodeList> getFundCodeList(
      {bool isReload = false, String filterText = ""}) async {
    var jsonText = "";
    if (!isReload) {
      if (_cacheFundCodeJson != "") {
        jsonText = _cacheFundCodeJson;
        print("getFundCodeList キャッシュから読み込み");
      } else {
        jsonText = await readFundCodeFile();
        print("getFundCodeList ファイルから読み込み");
      }
    }

    if (jsonText == "") {
      final client = http.Client();
      final response = await client.get("$_fundApiHost/code_list");
      if (response.body != "") {
        jsonText = response.body;
        print("getFundCodeList 通信から読み込み");
        await writeFundCodeFile(jsonText);
      }
    }

    _cacheFundCodeJson = jsonText;
    var codeList = parseFundCodeJson(jsonText);
    return getFuncCodeFilter(filterText, codeList);
  }

  CodeList getFuncCodeFilter(String filterText, CodeList codeList) {
    if (filterText == "") {
      return codeList;
    }

    var hankakuFilter = StringUtils.zenkakuToHankaku(filterText).toLowerCase();
    var resultCodeListValues = <CodeListValue>[];
    codeList.values.forEach((item) {
      if (StringUtils.zenkakuToHankaku(item.fundName)
              .toLowerCase()
              .indexOf(hankakuFilter) ==
          -1) {
        return;
      }
      resultCodeListValues.add(item);
    });

    return CodeList(context: codeList.context, values: resultCodeListValues);
  }

  Future<String> readTextFile() async {
    try {
      final file = await _fundCodeFile;
      return await file.readAsString();
    } catch (e) {
      return "";
    }
  }

  Future<String> readFundCodeFile() async {
    var text = "";
    try {
      final file = await _fundCodeFile;
      if (file.existsSync()) {
        text = await file.readAsString();
      }
    } catch (e) {
      text = "";
    }

    return text;
  }

  Future<bool> writeFundCodeFile(String text) async {
    try {
      final file = await _fundCodeFile;
      file.writeAsStringSync(text);
    } catch (e) {
      return false;
    }

    return true;
  }
}

class CodeList {
  final String context;
  final List<CodeListValue> values;

  CodeList({this.context, this.values});

  factory CodeList.fromJson(Map<String, dynamic> json) {
    var valueList = json["value"] as List;
    return CodeList(
      context: json["@odata.context"] as String,
      values: valueList.map((i) => CodeListValue.fromJson(i)).toList(),
    );
  }
}

class CodeListValue {
  final String fundName;
  final String isinCd;
  final String associationFundCd;
  final String fundCd;

  CodeListValue(
      {this.fundName, this.isinCd, this.associationFundCd, this.fundCd});

  factory CodeListValue.fromJson(Map<String, dynamic> json) {
    return CodeListValue(
      fundName: json["fund_name"] as String,
      isinCd: json["isin_cd"] as String,
      associationFundCd: json["association_fund_cd"] as String,
      fundCd: json["fund_cd"] as String,
    );
  }
}
