import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../add_task/add_task.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddTask(),
            ),
          );
        },
        child: Icon(Icons.add),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          padding: const EdgeInsets.all(20), // <-- Splash color
        ),
      ),
    );
  }
}
