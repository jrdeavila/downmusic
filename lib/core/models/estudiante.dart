// ignore_for_file: overridden_fields


import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/core/models/usuario.dart';

class Estudiante extends Usuario {
  final Curso curso;
  @override
  final String nombres, apellidos, telefono, usuarioId;
  @override
  final Identificacion identificacion;

  Estudiante(
      {required this.nombres,
      required this.apellidos,
      required this.identificacion,
      required this.telefono,
      required this.usuarioId,
      required this.curso})
      : super(
          nombres: nombres,
          apellidos: apellidos,
          telefono: telefono,
          identificacion: identificacion,
          usuarioId: usuarioId,
        );

  @override
  Map<String, dynamic> toMap() {
    var mapEstudiante = super.toMap();
    mapEstudiante.addAll({
      'role': getRole(),
      "curso": curso.toMap(),
    });
    return mapEstudiante;
  }

  factory Estudiante.fromFirebase(Map<String, dynamic> document) {
    return Estudiante(
        identificacion: Identificacion.fromFirestore(
            document["identificacion"] as Map<String, dynamic>),
        nombres: document["nombres"] as String,
        apellidos: document["apellidos"] as String,
        usuarioId: document["usuarioId"] as String,
        telefono: document["telefono"] as String,
        curso: Curso.fromFirebase(document['curso'] as Map<String, dynamic>));
  }

  @override
    String getRole() {
      return 'estudiante';
    }
}
