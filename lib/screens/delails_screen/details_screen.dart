import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phonebook/model/user.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;
  static String detailsRouteName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                user.avatar,
              ),
              radius: 55,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Name: ${user.name}",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Created at: " + DateFormat.yMd().add_Hm().format(user.createdAt),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "ID: ${user.id}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
