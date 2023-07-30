import 'package:blood_donation/components/carousal_sllider.dart';
import 'package:blood_donation/components/custom_card.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/request_card_list.dart';
import 'package:blood_donation/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../main.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  // String? str = sp?.getString('userName');

  @override
  Widget build(BuildContext context) {
    // final Future<SharedPreferences> sp = SharedPreferences.getInstance();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Save Life'),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 30,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push('/userAccount');
                },
                icon: Icon(
                  Icons.account_circle,
                  size: 35,
                )
                )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getVerticalSpace(10),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome Back !',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              CarousalImage(),
              getVerticalSpace(20),
              SizedBox(
                // width: screenWidth(context) * 0.95,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose Your Category',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    getVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomCard(
                          ontap: () {
                            MapsLauncher.launchQuery(
                              'Blood Bank Near Me'
                            );

                          },
                          txt: 'Find \n Blood bank',
                          icn: Icon(
                            MaterialCommunityIcons.blood_bag,
                            size: 40,
                            color: whiteColor,
                          ),
                        ),
                        CustomCard(
                          ontap: () {
                            MapsLauncher.launchQuery(
                              'Hospital Near Me'
                            );
                          },
                          txt: 'Find \n  Hospitals  ',
                          icn: Icon(
                            Icons.local_hospital,
                            size: 40,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                    getVerticalSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomCard(
                          ontap: () {},
                          txt: 'Call \n Ambulance',
                          icn: Icon(
                            MaterialCommunityIcons.ambulance,
                            size: 40,
                            color: whiteColor,
                          ),
                        ),
                        CustomCard(
                          ontap: () {},
                          txt: ' Donation \n   Request   ',
                          icn: Icon(
                            MaterialCommunityIcons.list_status,
                            size: 40,
                            color: whiteColor,
                          ),
                        )
                      ],
                    ),
                    getVerticalSpace(20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '',
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                    ),
                    getVerticalSpace(10),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
