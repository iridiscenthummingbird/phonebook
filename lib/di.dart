import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/core/database/app_database.dart';
import 'package:phonebook/managers/api_manager.dart';
import 'package:phonebook/managers/database_manager.dart';
import 'package:phonebook/repositories/users_repository.dart';

class DI extends StatelessWidget {
  const DI({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IDataBaseManager>(
          create: (context) => DataBaseManager(
            database: MyDatabase(),
          ),
        ),
        RepositoryProvider<IApiManager>(
          create: (context) => ApiManager(),
        ),
        RepositoryProvider<IUsersRepository>(
          create: (context) => UsersRepository(
            apiManager: context.read<IApiManager>(),
            dataBaseManager: context.read<IDataBaseManager>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
