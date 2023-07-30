import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/screens/Donate/donate.dart';
import 'package:blood_donation/screens/contribute/contribute.dart';
import 'package:blood_donation/screens/home/home.dart';
import 'package:blood_donation/screens/request_blood/request_blood_list.dart';
import 'package:flutter/material.dart';

import 'request_blood/add_blood_request.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({super.key});

  @override
  State<LandingHome> createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [Home(), Donate(), RequestBloodList(), Contribute()],
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
              icon: Icon(Icons.lan_outlined),
              text: 'Donate',
            ),
            Tab(
              icon: Icon(Icons.bloodtype_outlined),
              text: 'Blood',
            ),
            Tab(
              icon: Icon(Icons.attach_money_sharp),
              text: 'Contribute',
            ),
          ],
        ),
      ),
    );
  }
}
