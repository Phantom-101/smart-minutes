import 'package:flutter/material.dart';

class CreateTeam extends StatelessWidget {
  CreateTeam({Key? key}) : super(key: key);

  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 50),
        Center(
          child: Container(
            width: 400,
            child: TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 400,
            child: TextField(
              controller: _description,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Center(
          child: Container(
            width: 100,
            child: TextButton(
              onPressed: () {},
              child: const Text('Create'),
            ),
          ),
        ),
      ],
    );
  }
}