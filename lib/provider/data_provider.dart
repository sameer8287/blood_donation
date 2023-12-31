import 'package:blood_donation/model/blood_request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider{
  final ProviderRef ref;
  final _auth = FirebaseAuth.instance;
  FirebaseAuth _authCreate = FirebaseAuth.instance;
  DataProvider(this.ref);


  void login(String email, String pass,BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Homescreen()));
      EasyLoading.showSuccess('Login successfully');
      GoRouter.of(context).push('/landing');

      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('userName', email);
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
    });
  }

  void signUp(String email,String pass,context)
  {
    EasyLoading.show(status: 'Loading...');
                  _authCreate
                      .createUserWithEmailAndPassword(
                    email: email.toString(),
                    password: pass.toString(),
                  )
                      .then((value) {
                    EasyLoading.showSuccess('User Created Successfully');
                    GoRouter.of(context).pop();
                  }).onError((error, stackTrace) {
                    EasyLoading.showError(error.toString());
                  });
  }

  void logOut(BuildContext context)
  {
    EasyLoading.show(status: 'Loading');
            _auth.signOut().then((value) {
            EasyLoading.showSuccess('Logout Succesfully');
            GoRouter.of(context).pushReplacement('/login');
            }

            ).
            onError((error, stackTrace) {
              EasyLoading.showError(error.toString());
            });
  }
  void postBloodRequest(BloodRequestModel requestModel,BuildContext context)
  {
    final db = FirebaseFirestore.instance.collection('bloodRequest');
    db.add(requestModel.toJson())
    .then((value) {
      EasyLoading.showSuccess('Raised Request Sucessfully');
      GoRouter.of(context).pop();
    })
    .catchError((error){
      EasyLoading.showError(error.toString());
    })
    ;
  }
}

final getProvider = Provider<DataProvider>((ref) => DataProvider(ref));