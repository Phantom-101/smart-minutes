import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/views/dashboard/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
              child: const Text('Login'),
              onPressed: () async {
                if (await context.read<Database>().verifyEmailAndPassword(context.read<User>(), _email.text, _password.text)){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScaffold()));
                  var uuid = const Uuid();
                  var token = uuid.v4();
                  await context.read<Database>().changeUserToken(context.read<User>(), token);
                  const snackBar = SnackBar(content: Text('Successful Login!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  const snackBar = SnackBar(content: Text('Email or password does not exist'));
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