//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('mybox');

  //run this method if this is first time ever opening this app
  void createInitialData(){
    toDoList = [
      ["Follow @excelsusss on instagram", false],
      ["Slide left to delete ⬅️", false],
    ];
  }

  //to load the data from the database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);

  }

}