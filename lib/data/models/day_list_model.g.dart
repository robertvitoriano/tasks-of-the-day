// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayListModelAdapter extends TypeAdapter<DayListModel> {
  @override
  final int typeId = 1;

  @override
  DayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayListModel(
      id: fields[1] as int,
      title: fields[2] as String,
      tasks: (fields[3] as List?)?.cast<TaskModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
