import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phonebook/model/user.dart';
import 'package:phonebook/repositories/users_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit({required this.usersRepository}) : super(MainInitial());
  final IUsersRepository usersRepository;

  Stream<List<User>> get users => usersRepository.getUsersFromDB();

  Future<void> getUsers() async {
    try {
      usersRepository.addUsersToDB(await usersRepository.getUsersFromApi());
    } catch (e) {
      print(e);
    }
  }

  void deleteFromDB(int id) {
    usersRepository.deleteUserFromDB(id);
  }

  Future<void> deleteUser(int id) async {
    try {
      await usersRepository.deleteUser(id);
    } catch (e) {
      rethrow;
    }
  }
}
