import 'package:blood_donation/components/custom_text_field.dart';
import 'package:blood_donation/components/get_space.dart';
import 'package:blood_donation/components/round_btn.dart';
import 'package:blood_donation/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            getVerticalSpace(80),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.55,
              child: Image.asset('assets/signup.png'),
            ),
            getVerticalSpace(10),
            CustomTextField(cont: email, hint: 'Enter Email'),
            getVerticalSpace(10),
            CustomTextField(cont: pass, hint: 'Enter password'),
            getVerticalSpace(10),
            CustomTextField(cont: confirmpass, hint: 'Confirm password'),
            getVerticalSpace(30),
            Roundbtn(
                height: 0.06,
                title: "Create Account",
                ontap: () async {
                  if (email.text.isEmpty) {
                    EasyLoading.showError('Email Required');
                  } else if (confirmpass.text != pass.text) {
                    EasyLoading.showError('Password Miss Matched');
                  } else if (confirmpass.text.isEmpty && pass.text.isEmpty) {
                    EasyLoading.showError('Enter Password');
                  } else {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.setString('email', email.text.toString());
                    GoRouter.of(context).pushNamed('personalDetails',
                        queryParameters: {
                          'email': sp.getString('email'),
                          'pass': pass.text,
                          'id': 'true'
                        });
                  }
                })
          ]),
        ),
      ),
    );
  }
}
