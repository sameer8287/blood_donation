import 'dart:developer';
import 'package:blood_donation/components/custom_drop_down.dart';
import 'package:blood_donation/components/custom_text_field.dart';
import 'package:blood_donation/components/custom_time_picker.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/reusable_bottom_btn.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/model/personal_details_model.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PersonalDetailsForm extends ConsumerStatefulWidget {
  final String email;
  final String pass;
  final String id;
  final String firstName;
  final String lastName;
  final String dob;
  final String country;
  final String state;
  final String city;
  final String gender;
  final String bloodGroup;
  final String sufferedCovid19;
  
   PersonalDetailsForm(
      {super.key, 
      required this.email, 
      required this.pass, 
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.dob,
      required this.country,
      required this.state,
      required this.city,
      required this.gender,
      required this.bloodGroup,
      required this.sufferedCovid19
      });

  @override
  ConsumerState<PersonalDetailsForm> createState() =>
      _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends ConsumerState<PersonalDetailsForm> {
  TextEditingController firstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController customDescription = TextEditingController();

  String gender = '';
  String bloodGroupType = '';
  String sufferedCovid19 = '';
  String testedCovid19 = '';

  String country = '';
  String? state = '';
  String? city = '';
  String? dob = '';
  var box;

  void UpdatedValue()
  {
    firstName.text = widget.firstName;
    LastName.text = widget.lastName;
    dob = widget.dob;
    country = widget.country;
    state = widget.state;
    city =widget.city;
    gender = widget.gender;
    bloodGroupType = widget.bloodGroup;
    sufferedCovid19 = widget.sufferedCovid19;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdatedValue();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
          child:widget.id == "true" ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                'Enter Personal Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              getVerticalSpace(15),
              Row(
                children: [
                  Expanded(
                      child:
                          CustomTextField(cont: firstName, hint: 'First Name')),
                  getHorizontalSpace(10),
                  Expanded(
                      child: CustomTextField(
                    cont: LastName,
                    hint: 'Last Name',
                  ))
                ],
              ),
              getVerticalSpace(10),
              CustomDateTimePicker(

                hint: 'Date of Birth',

                getValue: (e) {
                  setState(() {
                    dob = e.toString();
                  });
                },
              ),
              getVerticalSpace(10),
              CSCPicker(
                layout: Layout.vertical,
                onCountryChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    state = value;
                  });
                },
                onCityChanged: (cty) {
                  // city = cty!;
                  setState(() {
                    city = cty;
                  });
                },
                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",
              ),
              getVerticalSpace(10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              getVerticalSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      value: 'Male',
                      title: Text('Male'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'Female',
                      title: Text('Female'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'Other',
                      title: Text('Other'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    )
                  ],
                ),
              ),
              getVerticalSpace(20),
              CustomDropDown(
                label: 'Blood Group',
                hint: 'Select Blood Goup Type',
                onChanged: (newValue) {
                  setState(() {
                    bloodGroupType = newValue.toString();
                  });
                },
                asyncItems: (_) async {
                  return [
                    'A+',
                    'B+',
                    'O+',
                    'A-',
                    'B-',
                    'O-',
                    'AB+',
                    'AB-',
                  ];
                },
                selectedItem: bloodGroupType,
              ),
              getVerticalSpace(10),
              Text(
                'Have you suffered from covid 19 in past?',
                style: TextStyle(fontSize: 20),
              ),
              getVerticalSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      value: 'Yes',
                      title: Text('Yes'),
                      groupValue: sufferedCovid19,
                      onChanged: (value) {
                        setState(() {
                          sufferedCovid19 = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'No',
                      title: Text('NO'),
                      groupValue: sufferedCovid19,
                      onChanged: (value) {
                        setState(() {
                          sufferedCovid19 = value.toString();
                        });
                      },
                    )
                  ],
                ),
              ),
              getVerticalSpace(10),
            ],
          ),
        ),
      )
      : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                'Enter Personal Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              getVerticalSpace(15),
              Row(
                children: [
                  Expanded(
                      child:
                          CustomTextField(cont: firstName, hint: 'First Name')),
                  getHorizontalSpace(10),
                  Expanded(
                      child: CustomTextField(
                    cont: LastName,
                    hint: 'Last Name',
                  ))
                ],
              ),
              getVerticalSpace(10),
              CustomDateTimePicker(
                hint: 'Date of Birth',
                getValue: (e) {
                  setState(() {
                    dob = e.toString();
                  });
                },
              ),
              getVerticalSpace(10),
              CSCPicker(
                layout: Layout.vertical,  
                currentCountry: country,
                currentState: state,
                currentCity: city,
                onCountryChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
                onStateChanged: (value) {
                  setState(() {
                    state = value;
                  });
                },
                onCityChanged: (cty) {
                  // city = cty!;
                  setState(() {
                    city = cty;
                  });
                },
                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",
              ),
              getVerticalSpace(10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              getVerticalSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      value: 'Male',
                      title: Text('Male'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'Female',
                      title: Text('Female'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'Other',
                      title: Text('Other'),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    )
                  ],
                ),
              ),
              getVerticalSpace(20),
              CustomDropDown(
                label: 'Blood Group',
                hint: 'Select Blood Goup Type',
                onChanged: (newValue) {
                  setState(() {
                    bloodGroupType = newValue.toString();
                  });
                },
                asyncItems: (_) async {
                  return [
                    'A+',
                    'B+',
                    'O+',
                    'A-',
                    'B-',
                    'O-',
                    'AB+',
                    'AB-',
                  ];
                },
                selectedItem: bloodGroupType,
              ),
              getVerticalSpace(10),
              Text(
                'Have you suffered from covid 19 in past?',
                style: TextStyle(fontSize: 20),
              ),
              getVerticalSpace(10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -5,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    RadioListTile(
                      value: 'Yes',
                      title: Text('Yes'),
                      groupValue: sufferedCovid19,
                      onChanged: (value) {
                        setState(() {
                          sufferedCovid19 = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'No',
                      title: Text('NO'),
                      groupValue: sufferedCovid19,
                      onChanged: (value) {
                        setState(() {
                          sufferedCovid19 = value.toString();
                        });
                      },
                    )
                  ],
                ),
              ),
              getVerticalSpace(10),
            ],
          ),
        ),
      )
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ReusableBottomButtons(
              ontap: () async {
                GoRouter.of(context).pop();
              },
              txt: 'Cancel',
              icn: const Icon(
                Icons.cancel,
                color: primary,
              ),
            ),
            ReusableBottomButtons(
              ontap: () async {
                if (firstName.text.isEmpty) {
                  EasyLoading.showError("First Name is Empty");
                } else if (LastName.text.isEmpty) {
                  EasyLoading.showError("Last Name is Empty");
                } else if (dob == '') {
                  EasyLoading.showError("DOB is Empty");
                } else if (country == '') {
                  EasyLoading.showError("Country is Empty");
                } else if (state == '') {
                  EasyLoading.showError("Country is Empty");
                } else if (city == '') {
                  EasyLoading.showError("City is Empty");
                } else if (gender == '') {
                  EasyLoading.showError("Select the gender");
                } else if (bloodGroupType == '') {
                  EasyLoading.showError("Select Blood Group");
                } else if (sufferedCovid19 == '') {
                  EasyLoading.showError("Select Covid 19 option");
                } else {
                  log(widget.email+" from personal details");
                  final data = PersonalDetailsModel(
                      firstName: firstName.text,
                      lastName: LastName.text,
                      dob: dob!,
                      country: country,
                      state: state!,
                      city: city!,
                      gender: gender,
                      bloodGroup: bloodGroupType,
                      sufferedCovid19: sufferedCovid19,
                      email: widget.email);
                  widget.id == 'true'
                      ? ref.read(getProvider).postUserDetails(
                          personalDetail: data,
                          context: context,
                          pass: widget.pass,
                          userName: widget.email)
                      : ref.read(getProvider).updateUserInfo(
                            updatedDetails: data,
                            context: context,
                          );
                }
              },
              txt: 'Save',
              icn: const Icon(
                Icons.check,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
