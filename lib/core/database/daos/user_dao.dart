import 'package:drift/drift.dart';
import 'package:phonebook/core/database/tables/user_table.dart';
import 'package:phonebook/model/user.dart';

import '../app_database.dart';

part 'user_dao.g.dart';
part '../mappers/user_mapper.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  UserDao(MyDatabase db) : super(db);

  Stream<List<User>> watchUsers() {
    return (select(userTable)
          ..orderBy(
            [(t) => OrderingTerm.asc(t.id)],
          ))
        .watch()
        .map(
          (event) => mapToUserList(event),
        );
  }

  Future<void> addUser(User user) async {
    await into(userTable).insert(
      userToMap(user),
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> saveUsers(List<User> users) async {
    await batch(
      (batch) {
        batch.insertAll(
          userTable,
          userListToMap(users),
          mode: InsertMode.insertOrReplace,
        );
      },
    );
  }

  Future deleteAllUsers() async {
    return await delete(userTable).go();
  }

  Future deleteUser(int id) async {
    return await (delete(userTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
