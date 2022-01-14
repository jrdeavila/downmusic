import 'package:downmusic/controllers/firebase_auth_controller.dart';
import 'package:downmusic/screens/home_screen.dart';
import 'package:downmusic/screens/login_module/authentication_screen.dart';
import 'package:downmusic/translator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/firebase_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  firebaseInitializedApp.then((value) {
    Get.put(FirebaseAuthController());
  });

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      translations: Translator(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      routes: {
        '/authentication': (context) => AuthenticationScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
