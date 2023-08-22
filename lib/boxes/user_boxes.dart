import 'package:blood_donation/model/hive/user_details_model.dart';
import 'package:hive/hive.dart';

class UserBoxes {
  static Box<UserDetailsModel> getData() =>
      Hive.box<UserDetailsModel>('userbox');
}
