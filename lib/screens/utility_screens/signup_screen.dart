import 'package:blood_donation/components/custom_text_field.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/round_btn.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          getVerticalSpace(80),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width * 0.55,
            child: Image.asset('assets/signup.png'),
          ),
          getVerticalSpace(10),
          CustomTextformField(cont: email, hint: 'Enter Email'),
          getVerticalSpace(10),
          CustomTextformField(cont: pass, hint: 'Enter password'),
          getVerticalSpace(10),
          CustomTextformField(cont: confirmpass, hint: 'Confirm password'),
          getVerticalSpace(30),
          Roundbtn(
              title: "Create Account",
              ontap: () {
                if (email.text.isEmpty) {
                  EasyLoading.showError('Email Required');
                } else if (confirmpass.text != pass.text) {
                  EasyLoading.showError('Password Miss Matched');
                } else {
                  ref.read(getProvider).signUp(email.text, pass.text, context);
                }
              })
        ]),
      ),
    );
  }
}
