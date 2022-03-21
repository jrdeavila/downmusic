import 'package:downmusic/controllers/firebase_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final firebaseAuthCtrl = Get.put(FirebaseAuthController());
  HomeScreen({Key? key}) : super(key: key);

  AppBar appBar(context, List<Choice> lchoices) {
    var userInfo = firebaseAuthCtrl.usuarioInfo.value;
    return AppBar(
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Text(
            "${userInfo?.nombres} ${userInfo?.apellidos}",
            style: const TextStyle(fontSize: 28.0),
          ),
        ),
      ),
      bottom: TabBar(
        isScrollable: true,
        tabs: lchoices
            .where((element) => true)
            .map<Widget>((choice) => Tab(
                  icon: Icon(choice.icon),
                  text: choice.title,
                ))
            .toList(),
      ),
    );
  }

  Widget body(List<Choice> lchoices) {
    return TabBarView(
        children: lchoices
            .where((element) => true)
            .map<Widget>((choice) => ChoicePage(choice: choice))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    // filter choices by user role
    final String? role = firebaseAuthCtrl.usuarioInfo.value?.getRole();
    final List<Choice> lchoices = choices.where((element) {
      if (element.roles.isEmpty) {
        return true;
      } else {
        return element.roles.contains(role);
      }
    }).toList();
    return DefaultTabController(
      length: lchoices.length,
      child: Scaffold(
        appBar: appBar(context, lchoices),
        body: body(lchoices),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  final Widget? widget;
  final List<String> roles;
  const Choice(
      {required this.roles,
      this.widget,
      required this.title,
      required this.icon});
}

List<Choice> choices = [
  Choice(
    roles: ['estudiante', 'docente'],
    title: 'subjects_label'.tr,
    icon: Icons.book,
  ),
  Choice(
    roles: ['estudiante'],
    title: 'course_label'.tr,
    icon: Icons.bookmark,
  ),
  Choice(
    roles: [
      'estudiante',
    ],
    title: 'ratings_label'.tr,
    icon: Icons.notes,
  ),
  Choice(
    roles: ['estudiante', 'docente'],
    title: 'activities_label'.tr,
    icon: Icons.local_activity,
  ),
  Choice(
    roles: [],
    title: 'user_info_label'.tr,
    icon: Icons.info,
  )
];

class ChoicePage extends StatelessWidget {
  final Choice choice;
  const ChoicePage({Key? key, required this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displaySmall!;
    return Card(
      child: choice.widget ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(choice.icon, size: 150, color: textStyle.color),
              Text(choice.title, style: textStyle),
            ],
          ),
    );
  }
}
