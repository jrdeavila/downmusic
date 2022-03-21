import 'package:downmusic/controllers/firebase_auth_controller.dart';
import 'package:downmusic/screens/home_screen.dart';
import 'package:downmusic/screens/login_module/auth_screen_web.dart';
import 'package:downmusic/screens/register_user_info.dart';
import 'package:downmusic/screens/waiting_courses_screen.dart';
import 'package:downmusic/translator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firebaseInitializedApp.then((value) {
    Get.put(FirebaseAuthController());
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'School Academic',
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      translations: Translator(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('waiting_for_firebase_service')
            ],
          ),
        ),
      ),
      routes: {
        '/authentication': (context) => AuthScreenWeb(),
        '/home': (context) => HomeScreen(),
        '/register-user-info': (context) => RegisterUserInfo(),
        '/waiting-cursos': (context) => const WaitingCoursesScreen(),
      },
    );
  }
}
