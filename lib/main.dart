import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'page/homepage.dart';

Future<void> main() async {

  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // primarySwatch: Colors.red,
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        // useMaterial3: true,
        // useMaterial3: false,
      ),
      home: MyHomePage(),
    );
  }
}

