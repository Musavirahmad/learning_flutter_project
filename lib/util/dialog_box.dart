import 'package:flutter/material.dart';
import 'package:learning_flutter_project/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a New Task",
              ),
            ),
            // button -> save and cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // save button
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),

                const SizedBox(
                  width: 4,
                ),
                // Cancel button
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
