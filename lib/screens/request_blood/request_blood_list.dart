// ignore_for_file: unnecessary_null_comparison
import 'package:blood_donation/components/custom_filled_btn.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RequestBloodList extends ConsumerStatefulWidget {
  const RequestBloodList({super.key});

  @override
  ConsumerState<RequestBloodList> createState() => _RequestBloodListState();
}

class _RequestBloodListState extends ConsumerState<RequestBloodList> {
  bool textfiledVisibilty = false;

  List<DocumentSnapshot> documents = [];

  int? isChipSelected1;
  List<RawChipModel> location = [
    RawChipModel(color: whiteColor, label: 'A+'),
    RawChipModel(color: whiteColor, label: 'B+'),
    RawChipModel(color: whiteColor, label: 'O+'),
    RawChipModel(color: whiteColor, label: 'A-'),
    RawChipModel(color: whiteColor, label: 'B-'),
    RawChipModel(color: whiteColor, label: 'O-'),
    RawChipModel(color: whiteColor, label: 'AB+'),
    RawChipModel(color: whiteColor, label: 'AB+'),
  ];

  // List<Widget> bloodGroupList() {

  //   List<Widget> chips = [];
  //   for (int i = 0; i < location.length; i++) {
  //     Widget item = RawChip(
  //       showCheckmark: false,
  //       labelPadding: const EdgeInsets.symmetric(horizontal: 22),
  //       disabledColor: Colors.black,
  //       side: BorderSide.none,
  //       label: Text(location[i].label),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       labelStyle: TextStyle(
  //           color: isChipSelected1 == i ? Colors.white : Colors.black,
  //           fontSize: 14),
  //       backgroundColor: location[i].color,

  //       onSelected: (bool value) {
  //         setState(() {
  //           isChipSelected1 = i;
  //         });
  //       },
  //     );
  //     chips.add(item);
  //   }
  //   return chips;
  // }

  List<Widget> bloodGroupList() {
    List<Widget> chips = [];
    for (int i = 0; i < location.length; i++) {
      Widget item = RawChip(
        showCheckmark: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 22),
        disabledColor: Colors.black,
        side: BorderSide.none,
        label: Text(location[i].label),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: TextStyle(
          color: isChipSelected1 == i ? Colors.white : Colors.black,
        ),
        backgroundColor: location[i].color,
        selected: isChipSelected1 == i,
        selectedColor: primary,
        onSelected: (bool value) {
          GoRouter.of(context).pop();
          setState(() {
            searchValue = location[i].label;
            isChipSelected1 = i;
            // locationValue = location[i].label;
            // checkArea = true;
          });
        },
      );
      chips.add(item);
    }
    return chips;
  }

  void bottomSheet() {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Blood Group',
                    style: TextStyle(fontSize: 22),
                  ),
                  getVerticalSpace(40.h),
                  Wrap(spacing: 9.1.w, children: bloodGroupList()),
                ],
              ),
              CustomFilledButton(
                onPressed: () {
                  GoRouter.of(context).pop();
                  setState(() {
                    searchValue = "";
                  });
                },
                textColor: whiteColor,
                buttonText: 'Clear Filter',
              )
            ],
          ),
        );
      },
    );
  }

  TextEditingController searchKey = TextEditingController();
  String searchValue = "";
  @override
  Widget build(BuildContext context) {
    var stream = ref.watch(getProvider).stream();
    var searchFromFirebase =
        ref.watch(getProvider).searchFromFirebase(searchValue);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () {
          //       setState(() {
          //         if (textfiledVisibilty) {
          //           textfiledVisibilty = false;
          //         } else {
          //           textfiledVisibilty = true;
          //         }
          //       });
          //     },
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //       // size: 30,
          //     )),
          title: textfiledVisibilty
              ? TextFormField(
                  controller: searchKey,
                  decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.search),
                      hintText: 'Search Blood Group'),
                  onChanged: (value) {
                    setState(() {
                      searchValue = value.toUpperCase();
                    });
                  },
                )
              : Text('Blood Request'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  bottomSheet();
                },
                icon: Icon(Icons.filter_list,color: searchValue== '' ? Colors.black : primary))
          ],
        ),
        body: Column(
          children: [
            getVerticalSpace(20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: searchValue == "" ? stream : searchFromFirebase,
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var d = streamSnapshot.data!.docs;

                  if (searchKey.text.length > 0) {
                    documents = documents.where((element) {
                      return element
                          .get('bloodGroup')
                          .toString()
                          .toLowerCase()
                          .contains(searchKey.text.toLowerCase());
                    }).toList();
                  }
                  if (streamSnapshot.hasError) {
                    return Text('Some thing went wrong');
                  }
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: -5,
                                blurRadius: 15,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${d[index]['firstName'].toString().toUpperCase()} ${d[index]['lastName'].toString().toUpperCase()}',
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: primaryClr,
                                      child: Text(
                                        d[index]['bloodGroup'],
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone Number',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 18),
                                        ),
                                        Text('Required Date',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18)),
                                        Text('Type',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18)),
                                        Text('Replacment Available',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18)),
                                        Text('Quantity',
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(d[index]['phoneNumber'].toString(),
                                            style: TextStyle(fontSize: 18)),
                                        Text(
                                            d[index]['requiredDate']
                                                .toString()
                                                .substring(0, 10),
                                            style: TextStyle(fontSize: 18)),
                                        Text(d[index]['type'],
                                            style: TextStyle(fontSize: 18)),
                                        Text(d[index]['replacement'],
                                            style: TextStyle(fontSize: 18)),
                                        Text(d[index]['quantity'].toString(),
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              GoRouter.of(context).push('/add_request_blood');
            },
            backgroundColor: primaryClr,
            label: Text(
              'Raised Blood Request',
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
      ),
    );
  }
}

class RawChipModel {
  final String label;
  final Color color;

  RawChipModel({required this.color, required this.label});
}
