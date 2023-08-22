import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  Future<void> splashServices()
  async{
    User? user;
    user =FirebaseAuth.instance.currentUser;

    Timer(Duration(seconds: 2),() async {

      // final SharedPreferences sp = await SharedPreferences.getInstance();
      // print('${sp.getString('userName')}+ value');
      // _auth.
      if(user != null)
      {
        GoRouter.of(context).push('/landing');
      }
      else
      {
        GoRouter.of(context).push('/login');
      }
       
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height *0.3,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset('assets/blood-donation.png')
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Be ',style: TextStyle(fontSize: 30,),),
                Text('a Life saver',style: TextStyle(fontSize: 20),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
