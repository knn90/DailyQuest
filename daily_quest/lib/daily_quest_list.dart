import 'package:flutter/material.dart';

class DailyQuestList extends StatefulWidget {
  
  const DailyQuestList({super.key, required this.title});
  final String title;

  @override
  State<DailyQuestList> createState() => _DailyQuestListState();
}

class _DailyQuestListState extends State<DailyQuestList> {
  final items = ["Quest 1", "Quest 2", "Quest 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return DailyQuestItemWidget(title: item,);
        })
    );
  }
}

class DailyQuestItemWidget extends StatefulWidget {
  final String title;
  const DailyQuestItemWidget({super.key, required this.title});

  @override
  State<DailyQuestItemWidget> createState() => _DailyQuestItemWidgetState();
}

class _DailyQuestItemWidgetState extends State<DailyQuestItemWidget> {
  bool? isDone = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isDone,
            onChanged: (bool? value) {
              setState(() {
                isDone = value;  
              });
          }),
          Text(widget.title),
        ],
      ),
    );
  }
}