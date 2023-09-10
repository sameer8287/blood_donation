import 'package:blood_donation/screens/forms/personal_details_form.dart';
import 'package:blood_donation/screens/landing_home.dart';
import 'package:blood_donation/screens/request_blood/add_blood_request.dart';
import 'package:blood_donation/screens/user_account.dart';
import 'package:blood_donation/screens/utility_screens/login.dart';
import 'package:blood_donation/screens/utility_screens/signup_screen.dart';
import 'package:blood_donation/screens/utility_screens/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

var routerProvider = Provider((ref) => GoRouter(initialLocation: '/', routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return SplashScreen();
          }),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          return SignUpScreen();
        },
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) {
          return LandingHome();
        },
      ),
      GoRoute(
        path: '/add_request_blood',
        builder: (context, state) {
          return AddRequestBlood();
        },
      ),
      GoRoute(
        path: '/userAccount',
        builder: (context, state) {
          return UserAccount();
        },
      ),
      GoRoute(
        path: '/personalDetails',
        name: 'personalDetails',
        builder: (context, state) {
          return PersonalDetailsForm(
            email: state.queryParameters['email'].toString() ,
            pass: state.queryParameters['pass'].toString(),
            id: state.queryParameters['id'].toString(),
            firstName: state.queryParameters['firstName'].toString(),
            lastName: state.queryParameters['lastName'].toString(),
            dob: state.queryParameters['dob'].toString(),
            bloodGroup: state.queryParameters['bloodGroup'].toString(),
            city: state.queryParameters['city'].toString(),
            country: state.queryParameters['country'].toString(),
            gender: state.queryParameters['gender'].toString(),
            state: state.queryParameters['state'].toString(),
            sufferedCovid19: state.queryParameters['sufferedCovid19'].toString(),
          );
        },
      )

    ]));
