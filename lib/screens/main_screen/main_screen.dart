import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/model/user.dart';
import 'package:phonebook/repositories/users_repository.dart';
import 'package:phonebook/screens/delails_screen/details_screen.dart';
import 'package:phonebook/screens/main_screen/cubit/main_cubit.dart';
import 'package:phonebook/utils/details_args.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainCubit _cubit;
  @override
  void initState() {
    _cubit = MainCubit(usersRepository: context.read<IUsersRepository>());
    _cubit.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/addUser');
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<User>>(
          stream: _cubit.users,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  User user = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailsScreen.detailsRouteName,
                        arguments: DetailsArgs(user: user),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                          onBackgroundImageError: (exception, stackTrace) {
                            //print(exception);
                          },
                        ),
                        title: Text(user.name),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
