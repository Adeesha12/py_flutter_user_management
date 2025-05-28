import 'package:flutter/material.dart';
import 'screens/user_form.dart';
import 'screens/user_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter + Django CRUD')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Add User'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const UserForm()));
              },
            ),
            ElevatedButton(
              child: const Text('View Users'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const UserList()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
