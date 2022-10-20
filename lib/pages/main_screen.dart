import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Task manager'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Main screen'),
          ElevatedButton(onPressed: () {
            Navigator.pushReplacementNamed(context, '/tasks');
          }, child: Text('Next'))
        ],
      ),
    );
  }
}
