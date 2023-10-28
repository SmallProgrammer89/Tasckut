
import 'package:hive/hive.dart';
part 'Type_enum.g.dart';
@HiveType(typeId: 3)
enum TaskTypeEnum {
    @HiveField(0)
  Working,
    @HiveField(1)
  DateWithFriend,
    @HiveField(2)
  Foucs,
    @HiveField(3)
  WorkingDate,
    @HiveField(4)
  Workout,
    @HiveField(5)
  BankingWork,
  @HiveField(6)
  Study,
  @HiveField(7)
  Shoping,

}
