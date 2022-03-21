import 'package:downmusic/controllers/user_info_controller.dart';
import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/widgets/datepicker_widget.dart';
import 'package:downmusic/widgets/dropdown_widget.dart';
import 'package:downmusic/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterUserInfo extends StatelessWidget {
  final UserInfoController userInfoCtrl = Get.put(UserInfoController());
  RegisterUserInfo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firstNameCtrl =
            TextEditingController(text: userInfoCtrl.firstName.value),
        phoneCtrl = TextEditingController(text: userInfoCtrl.phone.value),
        dniCtrl = TextEditingController(text: userInfoCtrl.dni.value),
        lastNameCtrl = TextEditingController(text: userInfoCtrl.lastName.value);
    return Scaffold(
      body: Obx(() {
        var errorFirstName = userInfoCtrl.validateFirstName();
        var errorLastName = userInfoCtrl.validateLastName();
        var errorPhone = userInfoCtrl.validatePhone();
        var errorDni = userInfoCtrl.validateDni();
        var errorBDay = userInfoCtrl.validateBDay();

        var errorGradeSelected = userInfoCtrl.validateCursoSelected();
        List<DropdownMenuItem<Curso>> itemsCurso =
            userInfoCtrl.lcursos.map<DropdownMenuItem<Curso>>((element) {
          return DropdownMenuItem<Curso>(
            value: element,
            child: Text(element.nombre),
          );
        }).toList();
        var _dropdownCursos = userInfoCtrl.lcursos.isNotEmpty
        ? DropdownWidget<Curso>(
            icon: Icons.grade,
            items: itemsCurso,
            hintText: 'select_a_curso_label'.tr,
            errorText: errorGradeSelected,
            onChanged: (Curso? value) => userInfoCtrl.setCursoSelected(value),
          )
        : Container();
        return ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          children: [
            SizedBox(
              height: 40,
              child: Text(
                'your_register_info_label'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextFieldWidget(
              controller: firstNameCtrl,
              icon: Icons.person,
              errorText: errorFirstName?.tr,
              hintText: 'first_name_label'.tr,
              onChanged: (value) => userInfoCtrl.setFirstName(value),
            ),
            TextFieldWidget(
              controller: lastNameCtrl,
              icon: Icons.person,
              errorText: errorLastName?.tr,
              hintText: 'last_name_label'.tr,
              onChanged: (value) => userInfoCtrl.setLastName(value),
            ),
            TextFieldWidget(
              controller: dniCtrl,
              icon: Icons.credit_card,
              hintText: 'dni_label'.tr,
              errorText: errorDni?.tr,
              onChanged: (value) => userInfoCtrl.setDni(value),
            ),
            TextFieldWidget(
              controller: phoneCtrl,
              icon: Icons.phone,
              hintText: 'phone_label'.tr,
              errorText: errorPhone?.tr,
              onChanged: (value) => userInfoCtrl.setPhone(value),
            ),
            DatePickerWidget(
                initialDate: userInfoCtrl.bDay.value,
                hintText: 'birthday_label'.tr,
                errorText: errorBDay?.tr,
                onChanged: (value) => userInfoCtrl.setBDay(value)),
            _dropdownCursos,
          ]
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userInfoCtrl.saveInfo();
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
