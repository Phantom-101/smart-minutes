import 'package:flutter/material.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/views/home/logged_in/view.dart';
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
                if (await context.read<MongoDatabase>().findOne({"email": _email.text}) != null){
                  const snackBar = SnackBar(content: Text('Email is already in use'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else {
                  var uuid = const Uuid();
                  var token = uuid.v4();
                  await context.read<MongoDatabase>().insertOne(<String,dynamic>{"email": _email.text,
                    "password": _password.text, "token": token});
                  await context.read<StorageUtil>().putString('token', token);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeLoggedIn()));
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