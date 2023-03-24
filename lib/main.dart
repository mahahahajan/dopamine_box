import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dopamine_box/components/alarms_helper.dart';
import 'package:dopamine_box/constants.dart';
import 'package:dopamine_box/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'components/database_helper.dart';

//Set up DatabaseHelper
final dbHelper = DatabaseHelper();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  await AndroidAlarmManager.initialize();
  runApp(const DopamineBoxApp());
  setupMorningAlarm();
  //If debugging
  setupDebugAlarms();
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
        applyElevationOverlayColor: false,
      ),
      home: const DopamineBoxHomeScreen(),
    );
  }
}

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
