import 'package:phonebook/managers/api_manager.dart';
import 'package:phonebook/managers/database_manager.dart';
import 'package:phonebook/managers/model/delete_request.dart';
import 'package:phonebook/managers/model/get_request.dart';
import 'package:phonebook/managers/model/post_request.dart';
import 'package:phonebook/model/user.dart';
import 'package:phonebook/utils/json_reader.dart';

abstract class IUsersRepository {
  final IApiManager apiManager;
  final IDataBaseManager dataBaseManager;

  IUsersRepository({
    required this.apiManager,
    required this.dataBaseManager,
  });

  Future<List<User>> getUsersFromApi();
  Stream<List<User>> getUsersFromDB();

  Future addUser(String name);
  Future deleteUser(int id);
}

class UsersRepository extends IUsersRepository {
  UsersRepository({
    required IApiManager apiManager,
    required IDataBaseManager dataBaseManager,
  }) : super(
          apiManager: apiManager,
          dataBaseManager: dataBaseManager,
        );

  @override
  Future addUser(String name) async {
    try {
      final result = apiManager
          .callApiRequest(PostRequest('/users', payload: {'name': name}));
      JsonReader reader = JsonReader(result);
      User addedUser = User.fromMap(reader.asObject());
      dataBaseManager.addUser(addedUser);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future deleteUser(int id) async {
    try {
      final result = apiManager.callApiRequest(DeleteRequest('/users/$id'));
      JsonReader reader = JsonReader(result);
      User deletedUser = User.fromMap(reader.asObject());
      dataBaseManager.deleteUser(deletedUser.id);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<User>> getUsersFromApi() async {
    List<User> users = [];
    try {
      final result = apiManager.callApiRequest(GetRequest('/users'));
      JsonReader reader = JsonReader(result);

      users = reader.asListOfObjects().map((e) => User.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return users;
  }

  @override
  Stream<List<User>> getUsersFromDB() {
    return dataBaseManager.watchUsers();
  }
}
