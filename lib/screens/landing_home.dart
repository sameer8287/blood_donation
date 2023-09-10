import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/notification_service/notification_service..dart';
import 'package:blood_donation/screens/Donate/donate.dart';
import 'package:blood_donation/screens/home/home.dart';
import 'package:blood_donation/screens/request_blood/request_blood_list.dart';
import 'package:blood_donation/screens/user_account.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({super.key});

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [Home(), RequestBloodList(), UserAccount()],
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: primary,
          labelColor: primary,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
           
            Tab(
              icon: Icon(Icons.bloodtype_outlined),
              text: 'Blood',
            ),
            Tab(
              icon: Icon(Icons.account_circle),
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
