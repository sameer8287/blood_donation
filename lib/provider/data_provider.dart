// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:blood_donation/model/blood_request_model.dart';
import 'package:blood_donation/model/personal_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  final ProviderRef ref;
  final _auth = FirebaseAuth.instance;
  FirebaseAuth _authCreate = FirebaseAuth.instance;
  DataProvider(this.ref);

  void login(String email, String pass, BuildContext context) {
    EasyLoading.show(status: 'Loading...');
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) async {
      EasyLoading.showSuccess('Login successfully');
      GoRouter.of(context).push('/landing');
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
    });
  }

  void signUp(String email, String pass, context) {
    _authCreate
        .createUserWithEmailAndPassword(
      email: email.toString(),
      password: pass.toString(),
    )
        .then((value) {
      EasyLoading.showSuccess('User Created Successfully');
      GoRouter.of(context).pop();
      GoRouter.of(context).pop();
      EasyLoading.showSuccess('Login with User Email and Pass');
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
    });
  }

  void logOut(BuildContext context) {
    EasyLoading.show(status: 'Loading');
    _auth.signOut().then((value) async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      EasyLoading.showSuccess('Logout Succesfully');
      GoRouter.of(context).pushReplacement('/login');
    }).onError((error, stackTrace) {
      EasyLoading.showError(error.toString());
    });
  }

  void postBloodRequest(BloodRequestModel requestModel, BuildContext context) {
    final db = FirebaseFirestore.instance.collection('bloodRequest');
    db.add(requestModel.toJson()).then((value) {
      EasyLoading.showSuccess('Raised Request Sucessfully');
      GoRouter.of(context).pop();
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }

  Stream<QuerySnapshot> searchFromFirebase(String data) {
    var search = FirebaseFirestore.instance
        .collection('bloodRequest')
        .where('bloodGroup', isEqualTo: data)
        .snapshots();
    return search;
  }
  
  Stream<QuerySnapshot> stream() {
    final userStream =
        FirebaseFirestore.instance.collection('bloodRequest').snapshots();
    return userStream;
  }

  void postUserDetails(
      {PersonalDetailsModel? personalDetail,
      BuildContext? context,
      String? userName,
      String? pass}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    EasyLoading.show(status: 'Loading...');
    final db = FirebaseFirestore.instance.collection('userDetails');
    db.add(personalDetail!.toJson()).then((DocumentReference doc) {
      signUp(userName!, pass!, context);
      log(doc.id.toString() + ' doc ID');
      sp.setString('userDetailDocId', doc.id.toString());
    }).catchError((error) {
      EasyLoading.showError(error.toString());
    });
  }

  Future<void> updateUserInfo(
      {PersonalDetailsModel? updatedDetails, BuildContext? context}) async {
    EasyLoading.show();
    SharedPreferences sp = await SharedPreferences.getInstance();
    var docID = sp.getString('userDetailDocId');
    log(docID.toString()+ "docID new ");
    FirebaseFirestore.instance
        .collection('userDetails')
        .doc(docID)
        .update(updatedDetails!.toJson())
        .then((value) {
      EasyLoading.showSuccess("Details Updated Successfully");
      GoRouter.of(context!).pop();
    }).catchError((e) {
      EasyLoading.showError(e.toString());
    });
    EasyLoading.dismiss();
  }

  Future<PersonalDetailsModel> fetchAccountDetails() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var id = sp.getString('email');
    log(id.toString() +" email");
    var data = await FirebaseFirestore.instance
        .collection('userDetails')
        .where('email', isEqualTo: id)
        .get();

    final userData =
        data.docs.map((e) => PersonalDetailsModel.fromSnapshot(e)).single;
    return userData;
  }
}

final getProvider = Provider<DataProvider>((ref) => DataProvider(ref));
