import 'package:sqflite/sqflite.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/data/services/database_provider.dart';

abstract class LocalDatabaseService {
  Future<int> insertTask(TaskModel task);
  Future<List<TaskModel>> getUncompletedTasks();
  Future<List<TaskModel>> getCompletedTasks();
  Future<List<TaskModel>> getAllTasks();
  Future<List<TaskModel>> getTasksByTitle(String title);
  Future<int> deleteTask(int id);
  Future<int> deleteAllDoneTasks();
  Future<int> updateTask(TaskModel task);
  Future<int> quantityOfUncompletedTasks();
}

class LocalDatabaseServiceImpl implements LocalDatabaseService {
  final DatabaseProvider _databaseProvider;

  LocalDatabaseServiceImpl({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  @override
  Future<int> insertTask(TaskModel task) async {
    final db = await _databaseProvider.database;
    return await db.insert('tasks', task.toMap());
  }

  @override
  Future<List<TaskModel>> getUncompletedTasks() async {
    final db = await _databaseProvider.database;
    final result = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [0],
    );
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  @override
  Future<List<TaskModel>> getCompletedTasks() async {
    final db = await _databaseProvider.database;
    final result = await db.query(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [1],
    );
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final db = await _databaseProvider.database;
    final result = await db.query('tasks');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  @override
  Future<List<TaskModel>> getTasksByTitle(String title) async {
    final db = await _databaseProvider.database;
    final result = await db.query(
      'tasks',
      where: 'LOWER(title) LIKE LOWER(?)',
      whereArgs: ['%$title%'],
    );
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  @override
  Future<int> deleteTask(int id) async {
    final db = await _databaseProvider.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> deleteAllDoneTasks() async {
    final db = await _databaseProvider.database;
    return await db.delete(
      'tasks',
      where: 'isCompleted = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<int> updateTask(TaskModel task) async {
    final db = await _databaseProvider.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  @override
  Future<int> quantityOfUncompletedTasks() async {
    final db = await _databaseProvider.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM tasks WHERE isCompleted = 0',
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
