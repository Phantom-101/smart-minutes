import 'package:flutter/material.dart';
import 'package:meeting_minutes/views/home/logged_in/view.dart';
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
                if (await context.read<MongoDatabase>().verifyEmailAndPassword(_email.text, _password.text)){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeLoggedIn()));
                  var uuid = const Uuid();
                  var token = uuid.v4();
                  await context.read<MongoDatabase>().changeUserToken(_email.text, token);
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