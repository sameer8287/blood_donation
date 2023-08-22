
import 'package:hive/hive.dart';
part'user_details_model.g.dart';

@HiveType(typeId: 0)
class UserDetailsModel extends HiveObject{
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String dob;
  @HiveField(3)
  String country;
  @HiveField(4)
  String state;
  @HiveField(5)
  String city;
  @HiveField(6)
  String gender;
  @HiveField(7)
  String bloodGroup;
  @HiveField(8)
  String covid19;
  UserDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.country,
    required this.state,
    required this.city,
    required this.gender,
    required this.bloodGroup,
    required this.covid19
  });
}