import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/repositories/users_repository.dart';
import 'package:phonebook/screens/add_user_screen/cubit/add_user_cubit.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AddUserCubit _cubit;
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    _cubit = AddUserCubit(
      usersRepository: context.read<IUsersRepository>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (await _cubit.addUser(_nameController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Success!"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error!"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
