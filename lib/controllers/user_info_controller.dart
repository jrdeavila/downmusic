import 'dart:developer';

import 'package:downmusic/core/database/cursos.dart';
import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/core/models/usuario.dart';
import 'package:get/get.dart';
import 'firebase_constants.dart' as constants;

import '../core/models/estudiante.dart';

class UserInfoController extends GetxController {
  final CursoFirebase cursoFirebase = CursoFirebase();
  final Rx<Curso?> cursoSelected = Rx<Curso?>(null);
  // final RxString firstName = ''.obs,
  //     lastName = ''.obs,
  //     phone = ''.obs,
  //     dni = ''.obs,
  //     typeDni = ''.obs;
  final RxString firstName = 'Jose Ricardo'.obs,
      lastName = 'De avila Moreno'.obs,
      phone = '3104535612'.obs,
      dni = '1003316620'.obs,
      typeDni = 'T.I'.obs;
  final Rx<DateTime?> bDay = Rx<DateTime?>(null);
  final RxList<Curso> lcursos = <Curso>[].obs;

  @override
  onReady() {
    super.onReady();
    ever(lcursos, _setListCursos);
    lcursos.bindStream(cursoFirebase.getModels());
  }

  _setListCursos(List<Curso> cursos) {
    if (cursos.isEmpty) {
      Get.offAllNamed('/waiting-cursos');
    } else {
      cursoSelected(cursos.first);
      Get.offAllNamed('/register-user-info');
    }
  }

  setFirstName(String value) {
    firstName(value);
  }

  setLastName(String value) {
    lastName(value);
  }

  setPhone(String value) {
    phone(value);
  }

  setDni(String value) {
    dni(value);
  }

  setTypeDni(String value) {
    typeDni(value);
  }

  setBDay(DateTime? value) {
    bDay(value);
  }

  setCursoSelected(Curso? value) {
    cursoSelected(value);
  }

  String? validateBDay() {
    var currentDate = DateTime.now();
    var bdayDate = bDay.value;
    if (bdayDate == null) {
      return 'bday_required_label'.tr;
    }
    if (bdayDate.day == currentDate.day &&
        bdayDate.month == currentDate.month &&
        bdayDate.year == currentDate.year) {
      return 'bday_cant_be_today_label'.tr;
    }
    return null;
  }

  String? validateCursoSelected() {
    if (cursoSelected.value == null) {
      return 'grade_selected_required'.tr;
    }
    return null;
  }

  String? validateLastName() {
    if (lastName.value.isEmpty) {
      return 'last_name_required';
    } else {
      var lastNameValid = RegExp(r"^[a-zA-Z\s]+$").hasMatch(lastName.value);
      if (lastNameValid) {
        return null;
      } else {
        return 'last_name_invalid';
      }
    }
  }

  String? validateFirstName() {
    if (firstName.value.isEmpty) {
      return 'first_name_required';
    } else {
      var firstNameValid = RegExp(r"^[a-zA-Z\s]+$").hasMatch(firstName.value);
      if (firstNameValid) {
        return null;
      } else {
        return 'first_name_invalid';
      }
    }
  }

  String? validatePhone() {
    if (phone.value.isEmpty) {
      return 'phone_required';
    } else {
      var phoneValid = RegExp(r"^[0-9]{10,10}$").hasMatch(phone.value);
      if (phoneValid) {
        return null;
      } else {
        return 'phone_invalid';
      }
    }
  }

  String? validateDni() {
    if (dni.value.isEmpty) {
      return 'dni_required';
    } else {
      var dniValid = RegExp(r"^[0-9]{8,10}$").hasMatch(dni.value);
      if (dniValid) {
        return null;
      } else {
        return 'dni_invalid';
      }
    }
  }

  bool _checkIfReadyToSave() {
    return validateBDay() == null &&
        validateFirstName() == null &&
        validateLastName() == null &&
        validatePhone() == null &&
        validateDni() == null &&
        validateCursoSelected() == null;
  }

  saveInfo() {
    if (_checkIfReadyToSave()) {
      var estudiante = Estudiante(
          nombres: firstName.value,
          apellidos: lastName.value,
          identificacion: Identificacion(numero: dni.value, tipo: 'T.I'),
          telefono: phone.value,
          usuarioId: constants.firebaseApp.currentUser!.uid,
          curso: cursoSelected.value!);
      cursoFirebase.addEstudiante(estudiante).then((value) {
        Get.snackbar('Save user', 'User added');
        Get.offAllNamed('/home');
      }).onError((error, stackTrace) {
        Get.snackbar(error.toString(), stackTrace.toString());
      });
    } else {
      log('not ready to save');
    }
  }
}
