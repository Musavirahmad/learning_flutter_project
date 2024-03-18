import 'package:hive/hive.dart';

class ToDoDatabase {
  List toDoList = [];
  //reference the box
  final _myBox = Hive.box('myBox');
//run this method if this is the first time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Excercise", false],
      ["Drink Water", false],
    ];
  }

  // load the data from the databse
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the datasbse
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
