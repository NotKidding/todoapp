import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import '../util/todo_tile.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {

    //if this is the first time ever opening the app, then create default data
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();

    }
    else{

      //there already exist data
      db.loadData();

    }
    super.initState();
  }

  //test controller
  final _controller = TextEditingController();


  //checkbox was tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();

  } 

  //save new task
  void saveNewTask(){
    setState(() {
       db.toDoList.add([ _controller.text, false]);
       _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
      );
  }

  // delete task
  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          title: Center(
            child: Text(
              'TODO.',
              style: GoogleFonts.italiana().copyWith(
              fontSize: 50.0,
             )
            ),
            
          
          ),
        backgroundColor: Colors.yellow,
        elevation: 0,
        )
        
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       // Drawer header
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.yellow,
      //         ),
      //         child: Icon(Icons.favorite,size: 100,),
              
              
      //       ),

      //       //theme
      //       ListTile(
      //         leading: Icon(Icons.dark_mode),
      //         title: const Text("Theme"),

      //         //on tap
      //         onTap: (){},


      //       ),

      //       //item 2
      //       ListTile(
      //         title: const Text("Item 2"),

      //         //on tap
      //         onTap: (){},
      //       )
      //     ],
      //   ),
      //),


      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            );
        },
      ),
    );
  }
}