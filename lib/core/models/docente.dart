// ignore_for_file: overridden_fields


import 'package:downmusic/core/models/asignatura_asignada.dart';
import 'package:downmusic/core/models/usuario.dart';

class Docente extends Usuario {
  @override
  final String nombres, apellidos, email, telefono, usuarioId;
  @override
  final Identificacion identificacion;
  final List<AsignaturaAsignada> asignaturas;

  Docente({
    required this.nombres,
    required this.apellidos,
    required this.identificacion,
    required this.email,
    required this.telefono,
    required this.usuarioId,
    required this.asignaturas,
  }) : super(
          nombres: nombres,
          apellidos: apellidos,
          telefono: telefono,
          identificacion: identificacion,
          usuarioId: usuarioId,
        );
  @override
  Map<String, dynamic> toMap() {
    var mapDocente = super.toMap();
    mapDocente.addAll({
      'role': getRole(),
      'asignaturas_asignadas':
          asignaturas.map((asignatura) => asignatura.toMap()).toList(),
    });
    return mapDocente;
  }

  factory Docente.fromFirebase(Map<String, dynamic> document) {
    return Docente(
      identificacion: Identificacion.fromFirestore(
          document["identificacion"] as Map<String, dynamic>),
      nombres: document["nombres"] as String,
      apellidos: document["apellidos"] as String,
      usuarioId: document["usuarioId"] as String,
      telefono: document["telefono"] as String,
      email: document["email"] as String,
      asignaturas: (document["asignaturas_asignadas"] as List)
          .map((asignatura) => AsignaturaAsignada.fromFirestore(
              asignatura as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
    String getRole() {
      return 'docente';
    }
}
