import 'package:sqflite/sqflite.dart';
import 'database_model.dart';

abstract class DatabaseProvider<T extends DatabaseModel> {
  Future open();
  Future<T> getItem(String id);
  Future<List<T>> getList();
  Future<bool> updateItem(String id, T model);
  Future<bool> removeItem(String id);
  Future<bool> insertItem(T model);

  Database database;

  Future<void> close() async {
    await database.close();
  }
}
