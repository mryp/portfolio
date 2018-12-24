import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PortfolioRecord {
  var id = 0;
  var associationFundCd = "";
  var title = "";
  var ratio = 0;
}

class PortfolioTable {
  static final tableName = "portfolio";
  static final columnId = "_id";
  static final columnAssociationFundCd = "associationFundCd";
  static final columnTitle = "title";
  static final columnRatio = "ratio";

  Database db;

  PortfolioTable(this.db);

  Map<String, dynamic> toMap(PortfolioRecord record) {
    var map = <String, dynamic>{
      columnAssociationFundCd: record.associationFundCd,
      columnTitle: record.title,
      columnRatio: record.ratio,
    };
    if (record.id != null) {
      map[columnId] = record.id;
    }
    return map;
  }

  PortfolioRecord fromMap(Map<String, dynamic> map) {
    var record = PortfolioRecord();
    record.id = map[columnId] as int;
    record.associationFundCd = map[columnAssociationFundCd] as String;
    record.title = map[columnTitle] as String;
    record.ratio = map[columnRatio] as int;

    return record;
  }

  Future<PortfolioRecord> insert(PortfolioRecord record) async {
    record.id = await db.insert(tableName, toMap(record));
    return record;
  }

  Future<PortfolioRecord> getRecord(int id) async {
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnAssociationFundCd, columnTitle, columnRatio],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(PortfolioRecord record) async {
    return await db.update(tableName, toMap(record),
        where: '$columnId = ?', whereArgs: [record.id]);
  }
}

class DatabaseProvider {
  static final dbFileName = "portfolio.db";
  static final version = 1;

  Database db;

  Future<Database> open({String path = ""}) async {
    if (path == "") {
      var databasesPath = await getDatabasesPath();
      path = join(databasesPath, 'demo.db');
    }

    db = await openDatabase(
      path,
      version: version,
      onCreate: (Database db, int version) async {
        await db.execute("create table ${PortfolioTable.tableName} (" +
            "${PortfolioTable.columnId} integer primary key autoincrement," +
            "${PortfolioTable.columnAssociationFundCd} text not null," +
            "${PortfolioTable.columnTitle} text not null," +
            "${PortfolioTable.columnRatio} integer not null)");
      },
    );

    return db;
  }

  Future close() async {
    db.close();
  }
}
