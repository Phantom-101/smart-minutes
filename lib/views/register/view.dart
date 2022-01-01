import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "REGISTER",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(hintText: "Your Email")
        ),
        TextField(
          onChanged: (value) {},
        ),
        TextButton(
          child: Text('REGISTER'),
          onPressed: () {},
        ),
      ],
    );
  }
}