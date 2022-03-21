import 'package:downmusic/core/models/asignatura.dart';
import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/core/models/model.dart';

class AsignaturaAsignada extends Model {
  final String asignaturaAsignadaId;
  final Asignatura asignatura;
  final Curso curso;
  AsignaturaAsignada(
      {required this.asignatura,
      required this.curso,
      required this.asignaturaAsignadaId});

  factory AsignaturaAsignada.fromFirestore(Map<String, dynamic> document) {
    return AsignaturaAsignada(
      asignaturaAsignadaId: document['asignaturaAsignadaId'],
      asignatura: Asignatura.fromFirebase(document['asignatura']),
      curso: Curso.fromFirebase(document['curso']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'asignaturaAsignadaId': asignaturaAsignadaId,
      'asignatura': asignatura.toMap(),
      'curso': curso.toMap(),
    };
  }

  @override
  String getDocumentId() {
    return asignaturaAsignadaId;
  }
}
