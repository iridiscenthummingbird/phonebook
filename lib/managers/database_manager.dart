import 'package:phonebook/core/database/app_database.dart';
import 'package:phonebook/model/user.dart';

abstract class IDataBaseManager {
  final MyDatabase database;

  IDataBaseManager(this.database);
  Future addUser(User user);
  Future deleteUser(int id);
  Stream<List<User>> watchUsers();
}

class DataBaseManager extends IDataBaseManager {
  DataBaseManager({required MyDatabase database}) : super(database);

  @override
  Future addUser(User user) {
    return database.userDao.addUser(user);
  }

  @override
  Future deleteUser(int id) {
    return database.userDao.deleteUser(id);
  }

  @override
  Stream<List<User>> watchUsers() {
    return database.userDao.watchUsers();
  }
}
