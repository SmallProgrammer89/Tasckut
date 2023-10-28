// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeEnumAdapter extends TypeAdapter<TaskTypeEnum> {
  @override
  final int typeId = 3;

  @override
  TaskTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskTypeEnum.Working;
      case 1:
        return TaskTypeEnum.DateWithFriend;
      case 2:
        return TaskTypeEnum.Foucs;
      case 3:
        return TaskTypeEnum.WorkingDate;
      case 4:
        return TaskTypeEnum.Workout;
      case 5:
        return TaskTypeEnum.Shoping;
      case 6:
        return TaskTypeEnum.Study;
      case 7:
        return TaskTypeEnum.BankingWork;
      default:
        return TaskTypeEnum.Working;
    }
  }

  @override
  void write(BinaryWriter writer, TaskTypeEnum obj) {
    switch (obj) {
      case TaskTypeEnum.Working:
        writer.writeByte(0);
        break;
      case TaskTypeEnum.DateWithFriend:
        writer.writeByte(1);
        break;
      case TaskTypeEnum.Foucs:
        writer.writeByte(2);
        break;
      case TaskTypeEnum.WorkingDate:
        writer.writeByte(3);
        break;
      case TaskTypeEnum.Workout:
        writer.writeByte(4);
        break;
      case TaskTypeEnum.Shoping:
        writer.writeByte(5);
        break;
        case TaskTypeEnum.Study:
        writer.writeByte(6);
        break;
      case TaskTypeEnum.BankingWork:
        writer.writeByte(7);
        break;
      
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
