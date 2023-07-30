import 'package:blood_donation/constant/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

class RequestBloodList extends StatefulWidget {
  const RequestBloodList({super.key});

  @override
  State<RequestBloodList> createState() => _RequestBloodListState();
}

class _RequestBloodListState extends State<RequestBloodList> {
  final _userStream =
      FirebaseFirestore.instance.collection('bloodRequest').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Request'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('Some thing went wrong');
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${snapshot.data!.docs[index]['firstName']} ${snapshot.data!.docs[index]['lastName']}',
                              style: TextStyle(fontSize: 22),
                            ),
                            CircleAvatar(
                              child: Text(
                                  snapshot.data!.docs[index]['bloodGroup']),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text('Required Date',
                                    style: TextStyle(fontSize: 18)),
                                Text('Type', style: TextStyle(fontSize: 18)),
                                Text('Replacment Available',
                                    style: TextStyle(fontSize: 18)),
                                Text('Quantity',
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    snapshot.data!.docs[index]['phoneNumber']
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                                Text(
                                    snapshot.data!.docs[index]['requiredDate']
                                        .toString()
                                        .substring(0, 10),
                                    style: TextStyle(fontSize: 18)),
                                Text(snapshot.data!.docs[index]['type'],
                                    style: TextStyle(fontSize: 18)),
                                Text(snapshot.data!.docs[index]['replacement'],
                                    style: TextStyle(fontSize: 18)),
                                Text(
                                    snapshot.data!.docs[index]['quantity']
                                        .toString(),
                                    style: TextStyle(fontSize: 18)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            GoRouter.of(context).push('/add_request_blood');
          },
          label: Text('Raised Blood Request')),
    );
  }
}
