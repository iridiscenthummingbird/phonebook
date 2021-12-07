import 'package:drift/drift.dart';

class UserTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get avatar => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
