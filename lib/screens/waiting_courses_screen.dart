import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitingCoursesScreen  extends StatelessWidget {
  const WaitingCoursesScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(), 
            const SizedBox(
              height: 10,
            ),
            Text('waiting_courses_screen_label'.tr),
          ],
        ),
      ),
    );
  }
}
