import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/round_btn.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAccount extends ConsumerStatefulWidget {
  const UserAccount({super.key});

  @override
  ConsumerState<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends ConsumerState<UserAccount> {
  @override
  Widget build(BuildContext context) {
    var data = ref.watch(getProvider).accountDetails();
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('User Account'),
            actions: [
              IconButton(
                  onPressed: () {
                    ref.read(getProvider).logOut(context);
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text('Something Went Wrong');
              }
              return SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      getVerticalSpace(20.h),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
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
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Text(
                                '${snapshot.data!.firstName.toString().substring(0, 1).toUpperCase()}',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            getHorizontalSpace(20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'User Name',
                                  style: TextStyle(color: Colors.black45),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      getVerticalSpace(20.h),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).cardColor,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.red),
                            ),
                            Divider(),
                            Text(
                              '${snapshot.data!.firstName} ${snapshot.data!.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Name',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.dob,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Date of Birth',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.bloodGroup,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Blood Group',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.email,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Email Address',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.country,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'country',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.state,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'state',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                            Text(
                              snapshot.data!.city,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'city',
                              style: TextStyle(color: Colors.black45),
                            ),
                            getVerticalSpace(10.h),
                          ],
                        ),
                      ),
                      getVerticalSpace(30.h),
                      Roundbtn(
                          title: 'LogOut',
                          ontap: () {
                            ref.read(getProvider).logOut(context);
                          },
                          height: 0.06)
                    ],
                  ),
                ),
              ));
            },
          )),
    );
  }
}
