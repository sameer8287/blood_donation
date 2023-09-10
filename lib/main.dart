import 'dart:developer';

import 'package:blood_donation/firebase_options.dart';
import 'package:blood_donation/model/hive/user_details_model.dart';
import 'package:blood_donation/notification_service/notification_service..dart';
import 'package:blood_donation/router/router.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log(message.data.toString());
  log(message.notification!.title.toString());
  log('test');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserDetailsModelAdapter());
  await Hive.openBox<UserDetailsModel>('userbox');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  
  LocalNotificationService.initialize();  
  runApp(
    DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => ProviderScope(child: MyApp()), // Wrap your app
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var router = ref.read(routerProvider);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) { 
        return ProviderScope(
          child: MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
