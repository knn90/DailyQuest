import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quest_details.dart';
import 'quest.dart';

class DailyQuestList extends StatefulWidget {
  
  const DailyQuestList({super.key, required this.title});
  final String title;

  @override
  State<DailyQuestList> createState() => _DailyQuestListState();
}

class _DailyQuestListState extends State<DailyQuestList> {
  var items = [
    Quest(title: "Quest 1"), 
    Quest(title: "Quest 2"),
    Quest(title: "Quest 3")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var quest = items[index];
          return ChangeNotifierProvider(
            create: (context) => quest,
            child: DailyQuestItemWidget(quest: quest,),
          );
      })
    );
  }
}

class DailyQuestItemWidget extends StatefulWidget {
  final Quest quest;
  const DailyQuestItemWidget({super.key, required this.quest});

  @override
  State<DailyQuestItemWidget> createState() => _DailyQuestItemWidgetState();
}

class _DailyQuestItemWidgetState extends State<DailyQuestItemWidget> {
  bool? isDone = false;

  @override
  void initState() {
    super.initState();
  }

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
    return GestureDetector(
      child: Center(
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
            Consumer<Quest>(builder: (context, quest, child) {
              return Text(quest.title);
            })
          ],
        ),
      ),
      onTap: () {
        Navigator
        .of(context)
        .push(MaterialPageRoute(
          builder: (context) => DailyQuestDetails(quest: widget.quest,)
          )
        );
      },
    );
  }
}