// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_daily_quest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalDailyQuestAdapter extends TypeAdapter<LocalDailyQuest> {
  @override
  final int typeId = 1;

  @override
  LocalDailyQuest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalDailyQuest(
      timestamp: fields[0] as String,
      tasks: (fields[1] as List).cast<LocalTask>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalDailyQuest obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalDailyQuestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
