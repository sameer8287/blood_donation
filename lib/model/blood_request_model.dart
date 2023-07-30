
class BloodRequestModel {
  String firstName;
  String lastName;
  int phoneNumber;
  int quantity;
  String replacement;
  String requiredDate;
  String type;
  String bloodGroup;
  BloodRequestModel({
    required this.bloodGroup,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.quantity,
    required this.replacement,
    required this.requiredDate,
    required this.type
  });

  toJson(){
    return{
      'bloodGroup':bloodGroup,
      'firstName': firstName,
      'lastName' : lastName,
      'phoneNumber':phoneNumber,
      'quantity' :  quantity,
      'replacement' :replacement,
      'requiredDate':requiredDate,
      'type':type

    };
  }
}

