import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/dashboard/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: "Email"),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 400,
            child: TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: "Password"),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: SizedBox(
            width: 100,
            child: TextButton(
              child: const Text('Register'),
              onPressed: () async {
                if (await context.read<Database>().emailExists(_email.text)){
                  const snackBar = SnackBar(content: Text('Email is already in use'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else {
                  var uuid = const Uuid();
                  var token = uuid.v4();
                  await context.read<Database>().createUser(context.read<User>(), _email.text, _password.text);
                  await context.read<Database>().changeUserToken(context.read<User>(), token);
                  await context.read<StorageUtil>().putString('token', token);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScaffold()));
                  const snackBar = SnackBar(content: Text('Registration Successful!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}