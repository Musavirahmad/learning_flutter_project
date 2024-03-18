import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learning_flutter_project/data/database.dart';
import 'package:learning_flutter_project/util/dialog_box.dart';
import 'package:learning_flutter_project/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //if this is the frist time ever openeing the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // the already exists data
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // list of todo tasks - commented as we are using database
  // List toDoList = [
  //   ["Make Tutorial", false],
  //   ["Do Excercise", true],
  //   ["Drink Water", false],
  // ];

// checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

// save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

// create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
    db.updateDatabase();
  }

  //delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 239, 129),
      appBar: AppBar(
        title: Center(child: Text("To Do App")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
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
