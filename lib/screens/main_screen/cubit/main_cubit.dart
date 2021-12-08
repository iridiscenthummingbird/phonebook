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
    usersRepository.addUsersToDB(await usersRepository.getUsersFromApi());
  }
}
