

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetailsModel {
  String firstName;
  String lastName;
  String dob;
  String country;
  String state;
  String city;
  String gender;
  String bloodGroup;
  String sufferedCovid19;
  String email;


  PersonalDetailsModel(
      {required this.firstName,
      required this.lastName,
      required this.dob,
      required this.country,
      required this.state,
      required this.city,
      required this.gender,
      required this.bloodGroup,
      required this.sufferedCovid19,
      required this.email
      });

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'country': country,
      'state': state,
      'city': city,
      'gender':gender,
      'bloodGroup':bloodGroup,
      'email': email,
      'sufferedFromCovid19':sufferedCovid19
    };
  }
  
  factory PersonalDetailsModel.fromSnapshot(DocumentSnapshot<Map<String ,dynamic>> document)
  {
    final data = document.data()!;
    return PersonalDetailsModel(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      bloodGroup: data['bloodGroup'],
      city: data['city'],
      country: data['country'],
      dob: data['dob'],
      gender: data['gender'],
      state: data['state'],
      sufferedCovid19: data['sufferedFromCovid19']
    );
  }
}
