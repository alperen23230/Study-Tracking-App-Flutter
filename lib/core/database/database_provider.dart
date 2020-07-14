import 'package:sqflite/sqflite.dart';
import 'database_model.dart';

abstract class DatabaseProvider<T extends DatabaseModel> {
  Future open();
  Future<T> getTodo(int id);
  Future<List<T>> getList();
  Future<bool> updateItem(int id, T model);
  Future<bool> removeItem(int id);
  Future<bool> insertItem(T model);

  Database database;

  Future<void> close() async {
    await database.close();
  }
}
