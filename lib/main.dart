//Nandu's Version

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/home_page.dart';


void main()async{

  //init hive
  await Hive.initFlutter();

  //open a box

  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(

        //textTheme: GoogleFonts.honkTextTheme(),
        
        primarySwatch: Colors.yellow,
        inputDecorationTheme: const InputDecorationTheme(
          //enabledBorder: OutlineInputBorder(
            //borderSide: BorderSide(color: Colors.black),

          //),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black
              ),
          )
        )
        ),
    );
  }
}