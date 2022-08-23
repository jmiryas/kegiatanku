import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../screens/main_menu_screen.dart';
import '../providers/timeline_provider.dart';
import '../providers/unplaned_task_provider.dart';
import '../providers/selected_timeline_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) {
        return TimelineProvider();
      }),
      ChangeNotifierProvider(create: (context) {
        return SelectedTimelineProvider();
      }),
      ChangeNotifierProvider(create: (context) {
        return UnplanedTaskProvider();
      })
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kegiatanku",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // primaryColor: const Color(0xFFB83B5E),
        primaryColor: Colors.amber,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(
            color: Colors.amber,
          ),
          selectedItemColor: Colors.amber,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const MainMenuScreen(),
    );
  }
}
