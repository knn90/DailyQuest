import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';

final class RemoteTaskFactory {
  RemoteTaskFactory._();

  static List<RemoteTask> makeList({required int count}) {
    List<RemoteTask> list = [];
    for (var i = 0; i < count; i++) {
      list.add(make(
        title: 'title {$i}',
        desciption: 'decription {$i}',
        isDone: i % 2 == 0,
      ));
    }
    return list;
  }

  static RemoteTask make({
    String title = 'any title',
    String desciption = 'any description',
    bool isDone = false,
  }) {
    return RemoteTask(title: title, description: desciption, isDone: isDone);
  }
}
