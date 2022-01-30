import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'db_model.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'tbl_order';

  static final proid = 'product_id';
  static final proName = 'name';
  static final proQuantity = 'qty';
  static final proPrice ='sale_price';
  static final tPrice = 'amount';
  static final rPrice = 'regular_rate';
  static final pImg = 'imagelink';

  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $proid INTEGER PRIMARY KEY,
            $proName TEXT NOT NULL,
            $proQuantity INTEGER NOT NULL,
            $proPrice INTEGER NOT NULL,
            $tPrice INTEGER NOT NULL,
            $pImg TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row) ;
  }
//TODO
  newClient(Model model) async {
    final db = await database;
    //var proidcheck = await db.rawQuery(" SELECT $proid FROM $table WHERE  ");
    var res = await db.rawInsert(
        "INSERT Into $table ($proid,$proName,$proQuantity,$proPrice,$tPrice,$pImg)"
            " VALUES (${model.pid},${model.pName},${model.pQuantity},"
            "${model.pPrice},${model.tPrice},${model.pImg})" );
    return res;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future checkProduct(String checkid) async {
    final  db = await instance.database;
    var returnID ;
    returnID = Sqflite.firstIntValue(await db.rawQuery('SELECT $proid FROM $table WHERE $proid= $checkid'));
    print(returnID);
    return returnID;
  }

  Future<int> updateCartList(Map<String, dynamic> row, int proID, ) async {
    Database db = await instance.database;
    // int id = int.parse(row[proid]);

    return await db.update(table, row, where: '$proid = ?', whereArgs: [proID]);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[proid];
    return await db.update(table, row, where: '$proid = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {    //change string to int
    Database db = await instance.database;
    return await db.delete(table, where: '$proid = ?', whereArgs: [id]);
  }

  Future deleteall() async {    //change string to int
    final db = await database;
    db.delete('$table');
  }

  Future<int?> subtotal() async{
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT  SUM($tPrice) FROM $table'));
  }
  // Future<int?> dataID(int inndex) async{
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('SELECT  SUM($tPrice) FROM $table'));
  // }

  //TODO
  // Future<int> resCount() async{
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('select count(*) from (SELECT COUNT($resid) as res  FROM $table GROUP by $resid) as x'));
  //
  // }

  // Future<int?> rowCount() async{
  //   Database db = await instance.database;
  //   return Sqflite.firstIntValue(await db.rawQuery('select count(*) from $table'));
  // }

// select count(*) from (SELECT COUNT(restaurant_id) as res  FROM `all_products` GROUP by restaurant_id) as x

}