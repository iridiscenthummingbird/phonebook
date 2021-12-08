import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:phonebook/repositories/users_repository.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  AddUserCubit({
    required this.usersRepository,
  }) : super(AddUserInitial());
  final IUsersRepository usersRepository;

  Future<bool> addUser(String name) async {
    return usersRepository.addUser(name);
  }
}
