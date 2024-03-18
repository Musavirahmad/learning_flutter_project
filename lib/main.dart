import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learning_flutter_project/pages/home_page.dart';

Future main() async {
  //init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('myBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
