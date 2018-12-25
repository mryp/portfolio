import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class PortfolioRecord {
  static final columnId = "id";
  static final columnAssociationFundCd = "associationFundCd";
  static final columnTitle = "title";
  static final columnRatio = "ratio";

  var id = "";
  var associationFundCd = "";
  var title = "";
  var ratio = 0;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnAssociationFundCd: associationFundCd,
      columnTitle: title,
      columnRatio: ratio,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  PortfolioRecord fromMap(Map<String, dynamic> map) {
    var record = PortfolioRecord();
    record.id = map[columnId] as String;
    record.associationFundCd = map[columnAssociationFundCd] as String;
    record.title = map[columnTitle] as String;
    record.ratio = map[columnRatio] as int;

    return record;
  }
}

class PortfolioTable {
  void insert(PortfolioRecord record) async {
    //とりあえず接続だけ
    var result = await Firestore.instance.collection('portfolio').add(record.toMap());
  }
}
