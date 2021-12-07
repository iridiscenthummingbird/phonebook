import 'package:drift/drift.dart';
import 'package:phonebook/core/database/tables/user_table.dart';

import '../app_database.dart';

part 'user_dao.g.dart';
part '../mappers/user_mapper.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<MyDatabase> with _$UserDaoMixin {
  UserDao(MyDatabase db) : super(db);
}
