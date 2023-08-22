import 'dart:io';

import 'package:blood_donation/constant/colors.dart';
import 'package:blood_donation/screens/Donate/donate.dart';
import 'package:blood_donation/screens/home/home.dart';
import 'package:blood_donation/screens/request_blood/request_blood_list.dart';
import 'package:blood_donation/screens/user_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      child:Scaffold(
        body: TabBarView(
          children: [Home(), Donate(), RequestBloodList(), UserAccount()],
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
              icon: Icon(Icons.account_circle),
              text: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
