import 'package:blood_donation/components/custom_drop_down.dart';
import 'package:blood_donation/components/custom_text_field.dart';
import 'package:blood_donation/components/custom_time_picker.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/round_btn.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/model/blood_request_model.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:blood_donation/provider/state_notifier/quantity_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddRequestBlood extends ConsumerStatefulWidget {
  const AddRequestBlood({super.key});

  @override
  ConsumerState<AddRequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends ConsumerState<AddRequestBlood> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  String type = '';
  String bloodGroupType = '';
  String replacement = '';
  int quantity = 0;
  String? scheduleDate;

  void add() {
    setState(() {
      quantity++;
    });
  }

  void subtract() {
    setState(() {
      quantity--;
    });
  }

  // void showBottomSheet() {
  //   showModalBottomSheet(
  //     isScrollControlled: false,
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           width: double.infinity,
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Select Quantity',
  //                 style: TextStyle(
  //                   fontSize: 22,
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       if (q == 0) {
  //                       } else {
  //                         ref.read(quantityProvider.notifier).subtract();
  //                       }
  //                     },
  //                     child: Container(
  //                       height: 40.h,
  //                       width: 40.w,
  //                       decoration: BoxDecoration(
  //                           color: primary, shape: BoxShape.circle),
  //                       child: Center(
  //                         child: Icon(
  //                           Icons.remove,
  //                           color: whiteColor,
  //                           size: 20,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Text(
  //                     ref.watch(quantityProvider.notifier).quantity.toString(),
  //                     style: TextStyle(fontSize: 28, color: primary),
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       ref.read(quantityProvider.notifier).add();
  //                     },
  //                     child: Container(
  //                       height: 40.h,
  //                       width: 40.w,
  //                       decoration: BoxDecoration(
  //                           color: primary, shape: BoxShape.circle),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(
  //                             Icons.add,
  //                             color: whiteColor,
  //                             size: 20,
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    int quant = ref.watch(quantityProvider.notifier).quantity;
    return Scaffold(
        appBar: AppBar(
          title: Text('Blood Request'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 1,
          
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerticalSpace(15),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              cont: firstName, hint: 'First Name')),
                      getHorizontalSpace(10),
                      Expanded(
                          child: CustomTextField(
                        cont: lastName,
                        hint: 'Last Name',
                      ))
                    ],
                  ),
                  getVerticalSpace(10),
                  CustomTextField(cont: PhoneNumber, hint: 'Phone Number'),
                  getVerticalSpace(10),
                  CustomDateTimePicker(
                    hint: 'Required date',
                    getValue: (value) {
                      setState(() {
                        scheduleDate = value;
                      });
                    },
                  ),
                  getVerticalSpace(15),
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
                  getVerticalSpace(15),
                  Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  getVerticalSpace(15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -5,
                          blurRadius: 15,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 'Blood',
                          title: Text('Blood'),
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          value: 'Platelets',
                          title: Text('Platelets'),
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          value: 'Plasma',
                          title: Text('Plasma'),
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value.toString();
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  getVerticalSpace(15),
                  Text(
                    'Replacement Availbale',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  getVerticalSpace(15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: -5,
                          blurRadius: 15,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          value: 'Yes',
                          title: Text('Yes'),
                          groupValue: replacement,
                          onChanged: (value) {
                            setState(() {
                              replacement = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          value: 'No',
                          title: Text('No'),
                          groupValue: replacement,
                          onChanged: (value) {
                            setState(() {
                              replacement = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  getVerticalSpace(20),
                  Text(
                    'Select Quantity',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  getVerticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          if (quantity == 0) {
                          } else {
                            subtract();
                          }
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: primary, shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: whiteColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${quantity.toString()} Unit',
                        style: TextStyle(fontSize: 28, color: primary),
                      ),
                      InkWell(
                        onTap: () {
                          add();
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                              color: primary, shape: BoxShape.circle),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: whiteColor,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  getVerticalSpace(30),
                  Roundbtn(
                      height: 0.06,
                      title: 'Request Blood',
                      ontap: () {
                        if (bloodGroupType.isEmpty) {
                          EasyLoading.showError('Select Blood Group');
                        } else if (firstName.text.isEmpty ||
                            lastName.text.isEmpty) {
                          EasyLoading.showError('Full Name is Mandatory');
                        } else if (PhoneNumber.text.isEmpty) {
                          EasyLoading.showError('Phone Number is Mandatory');
                        } else if (quantity == 0) {
                          EasyLoading.showError('Quantity should be atleast 1');
                        } else if (replacement.isEmpty) {
                          EasyLoading.showError(
                              'Select the Replacement Availability');
                        } else if (scheduleDate.toString().isEmpty) {
                          EasyLoading.showError('Required Date is Mandatory');
                        } else if (type.isEmpty) {
                          EasyLoading.showError('Select the type');
                        } else {
                          ref.read(getProvider).postBloodRequest(
                              BloodRequestModel(
                                bloodGroup: bloodGroupType,
                                firstName: firstName.text,
                                lastName: lastName.text,
                                phoneNumber: int.parse(PhoneNumber.text),
                                quantity: quantity,
                                replacement: replacement,
                                requiredDate: scheduleDate.toString(),
                                type: type,
                              ),
                              context);
                        }
                      }),
                  getVerticalSpace(30),
                ],
              ),
            ),
          ),
        ));
  }
}
