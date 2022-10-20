import 'package:flutter/material.dart';
import 'package:task_manager/pages/hohoome.dart';
import 'package:task_manager/pages/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/tasks',
      routes: {
        '/': (context) => MainScreen(),
        '/tasks': (context) => Home()
      },
    );
  }
}
