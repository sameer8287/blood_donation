// ignore_for_file: unnecessary_null_comparison
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestBloodList extends StatefulWidget {
  const RequestBloodList({super.key});

  @override
  State<RequestBloodList> createState() => _RequestBloodListState();
}

class _RequestBloodListState extends State<RequestBloodList> {
  Stream<QuerySnapshot> stream() {
    final userStream =
        FirebaseFirestore.instance.collection('bloodRequest').snapshots();
    return userStream;
  }

  List<DocumentSnapshot> documents = [];

  Stream<QuerySnapshot> searchFromFirebase(String data) {
    var search = FirebaseFirestore.instance
        .collection('bloodRequest')
        .where('bloodGroup', isEqualTo: data)
        .snapshots();
    return search;
  }

  TextEditingController searchKey = TextEditingController();
  String searchValue = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Blood Request'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            getVerticalSpace(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchKey,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Blood Group'),
                onChanged: (value) {
                  setState(() {
                    searchValue = value.toUpperCase();
                  });
                },
              ),
            ),
            getVerticalSpace(20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: searchValue == ""
                    ? stream()
                    : searchFromFirebase(searchValue),
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
