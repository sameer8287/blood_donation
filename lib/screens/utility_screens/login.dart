
// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:blood_donation/components/round_btn.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  
  final emilcont = TextEditingController();
  final passcont = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Image.asset('assets/login.png')),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: emilcont,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                              label: Text('Email'),
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Enter email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passcont,
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(Icons.password_outlined),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )),
                Roundbtn(
                  height: 0.06,
                    title: 'Login',
                    ontap: () async{
                      
                      if (_formkey.currentState!.validate()) {
                        ref.read(getProvider).login(emilcont.text, passcont.text, context);
                      }
                    }),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      )),
                      Text('  Or  '),
                      Expanded(
                          child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account ?"),
                    TextButton(
                        onPressed: () {
                          GoRouter.of(context).push('/signup');
                        },
                        child: Text('Create Account'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
