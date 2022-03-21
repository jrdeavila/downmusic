import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/core/models/estudiante.dart';
import 'package:downmusic/core/models/model.dart';

class CursoEstudiante extends Model {
  final String cursoEstudianteid;
  final String cursoNombre;
  final Curso curso;
  final List<Estudiante> estudiantes;

  CursoEstudiante({
    required this.cursoNombre,
    required this.curso,
    required this.cursoEstudianteid,
    required this.estudiantes,
  });

  factory CursoEstudiante.fromFirebase(Map<String, dynamic> document) {
    return CursoEstudiante(
      curso: Curso.fromFirebase(document['curso'] as Map<String, dynamic>),
      cursoNombre: document['cursoNombre'] as String,
      cursoEstudianteid: document['cursoEstudianteId'] as String,
      estudiantes: (document['estudiantes'] as List<dynamic>).map((e) {
        return Estudiante.fromFirebase(e);
      }).toList(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'cursoNombre': cursoNombre,
      'cursoEstudianteId': cursoEstudianteid,
      'estudiantes': estudiantes.map((e) => e.toMap()).toList(),
      'curso': curso.toMap(),
    };
  }

  @override
  String getDocumentId() {
    return cursoEstudianteid;
  }
}
