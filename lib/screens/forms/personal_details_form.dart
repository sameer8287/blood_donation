import 'dart:developer';

import 'package:blood_donation/components/custom_cupertino_textfield.dart';
import 'package:blood_donation/components/custom_descrption_bo.dart';
import 'package:blood_donation/components/custom_drop_down.dart';
import 'package:blood_donation/components/custom_text_field.dart';
import 'package:blood_donation/components/custom_time_picker.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/reusable_bottom_btn.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  TextEditingController firstName = TextEditingController();
  TextEditingController LastName = TextEditingController();
  TextEditingController customDescription = TextEditingController();
  String gender = '';
  String bloodGroupType = '';
  String sufferedCovid19 = '';
  String testedCovid19 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                      child: CustomTextformField(
                          cont: firstName, hint: 'First Name')),
                  getHorizontalSpace(10),
                  Expanded(
                      child: CustomTextformField(
                    cont: LastName,
                    hint: 'Last Name',
                  ))
                ],
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
                    'A +',
                    'B +',
                    'O +',
                    'A -',
                    'B -',
                    'O -',
                    'AB +',
                    'AB -',
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
              CustomDateTimePicker(
                hint: 'Date of Birth',
                getValue: (e) {
                  log(e);
                },
              ),
              CustomDiscriptionBox(
                notes: customDescription,
                txt: 'Address',
              )
            ],
          ),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ReusableBottomButtons(
              ontap: () {
                GoRouter.of(context).pop();
              },
              txt: 'Cancel',
              icn: const Icon(
                Icons.cancel,
                color: primary,
              ),
            ),
            ReusableBottomButtons(
              ontap: () {},
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
