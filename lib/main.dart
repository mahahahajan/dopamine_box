import 'dart:ffi';

import 'package:cron/cron.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'components/database_helper.dart';
import 'firebase_options.dart';

//Set up DatabaseHelper
final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(const DopamineBoxApp());
}

class DopamineBoxApp extends StatelessWidget {
  const DopamineBoxApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dopamine Box',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: darkThemeBackgroundColor,
        //         // backgroundColor: darkThemeBackgroundColor,
        //         // textTheme: GoogleFonts.poppinsTextTheme().apply(
        //         //   bodyColor: headerTextColor,
        //         // ),
        //         applyElevationOverlayColor: false,
        //       ),
        applyElevationOverlayColor: false,
      ),
      home: DopamineBoxHomeScreen(),
    );
  }
}

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => const DopamineBoxApp(), // Wrap your app
//     ),
//   );
// }

// class DopamineBoxApp extends StatelessWidget {
//   const DopamineBoxApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dopamine Box',
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       theme: ThemeData.dark().copyWith(
//         useMaterial3: true,
//         scaffoldBackgroundColor: darkThemeBackgroundColor,
//         // backgroundColor: darkThemeBackgroundColor,
//         // textTheme: GoogleFonts.poppinsTextTheme().apply(
//         //   bodyColor: headerTextColor,
//         // ),
//         applyElevationOverlayColor: false,
//       ),
//       home: DopamineBoxHomeScreen(),
//     );
//   }
// }
