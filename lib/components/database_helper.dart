import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../constants.dart';
import 'my_task.dart';

class DatabaseHelper {
  static const _databaseName = "TaskDatabase.db";
  static const _databaseVersion = 1;

  String taskTable = 'task_table';
  String colId = 'id';
  String colTaskName = 'taskName';
  String colIsComplete = 'isComplete';
  String colStreakCounter = 'streakCounter';

  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        ''' CREATE TABLE $taskTable ( $colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTaskName TEXT, $colIsComplete INTEGER, $colStreakCounter INTEGER )''');
    await initDB(db);
  }

  // Helper methods
  //Create default tasks if this is our first time
  Future<void> initDB(Database currDB) async {
    // var currDB = await this._db;
    for (int i = 0; i < defaultTasks.length; i++) {
      MyTask currTask = MyTask(
          taskName: defaultTasks[i],
          isComplete: 0,
          streakCounter: 0,
          taskId: i);
      await currDB.insert(taskTable, currTask.toMap());
    }
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(MyTask myTask) async {
    var result = await _db.insert(taskTable, myTask.toMap());
    return result;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var query = await _db.query(taskTable);
    return query;
  }

  Future<List<Map<String, dynamic>>?> querySpecificRow(int id) async {
    var query = await _db.query(
      taskTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (query.isNotEmpty) {
      return query;
    }
    return null;
  }

  // // All of the methods (insert, query, update, delete) can also be done using
  // // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount() async {
  //   final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
  //   return Sqflite.firstIntValue(results) ?? 0;
  // }

  // // We are assuming here that the id column in the map is set. The other
  // // column values will be used to update the row.
  Future<int> updateOld(Map<String, dynamic> row) async {
    int id = row[colId];
    return await _db.update(
      taskTable,
      row,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(int id, int value) async {
    // var row = await querySpecificRow(id);
    return await _db.update(
      taskTable,
      {'isComplete': value},
      where: '$colId = ?',
      whereArgs: [id],
    );
  }

  Future<void> resetTasks() async {
    await _db.rawUpdate('UPDATE task_table SET isComplete = 0');
  }

  // // Deletes the row specified by the id. The number of affected rows is
  // // returned. This should be 1 as long as the row exists.
  // Future<int> delete(int id) async {
  //   return await _db.delete(
  //     table,
  //     where: '$columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
