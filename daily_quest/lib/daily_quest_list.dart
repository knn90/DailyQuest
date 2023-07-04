import 'package:flutter/material.dart';

class DailyQuestList extends StatefulWidget {
  
  const DailyQuestList({super.key, required this.title});
  final String title;

  @override
  State<DailyQuestList> createState() => _DailyQuestListState();
}

class _DailyQuestListState extends State<DailyQuestList> {
  final items = [
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
          final quest = items[index];
          return DailyQuestItemWidget(quest: quest,);
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
            Text(widget.quest.title),
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

class DailyQuestDetails extends StatefulWidget {
  const DailyQuestDetails({super.key, required this.quest});
  final Quest quest;

  @override
  State<DailyQuestDetails> createState() => _DailyQuestDetailsState();
}

class _DailyQuestDetailsState extends State<DailyQuestDetails> {

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.quest.title);
    _descriptionController = TextEditingController();
  }

  @override 
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quest Details")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            controller: _descriptionController,
            maxLines: 5,
          )
        ],
      ),
    );
  }
}

class Quest {
  String title;
  String? description;

  Quest({required this.title, this.description});
}