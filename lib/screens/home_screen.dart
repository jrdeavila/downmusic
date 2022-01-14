import 'package:downmusic/controllers/firebase_auth_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Home Screen'),
            ElevatedButton(child: const Text('Logout'), onPressed: (){
              FirebaseAuthController.authInstance.logout();
            }),
          ],
        ),
      ),
    );
  }
}
