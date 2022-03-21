
import 'package:downmusic/core/models/asignatura.dart';
import 'package:downmusic/core/models/curso_estudiantes.dart';

import 'model.dart';

class Actividad extends Model{
  final String actividadId;
  final String nombre;
  final String descripcion;
  final CursoEstudiante cursoEstudiante;
  final Asignatura asignatura;
  
  Actividad({
    required this.actividadId,
    required this.nombre,
    required this.descripcion,
    required this.cursoEstudiante,
    required this.asignatura
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'actividadId': actividadId,
      'nombre': nombre,
      'descripcion': descripcion,
      'cursoEstudiante': cursoEstudiante.toMap(),
      'asignatura': asignatura.toMap()
    };
  }
  

  factory Actividad.fromFirebase(Map<String, dynamic> document){
    return Actividad(
      actividadId: document['actividadId'],
      nombre: document['nombre'],
      descripcion: document['descripcion'],
      cursoEstudiante: CursoEstudiante.fromFirebase(document['cursoEstudiante']),
      asignatura: Asignatura.fromFirebase(document['asignatura'])
    );
  }
  
  @override
  String getDocumentId() {
    return actividadId;
  }


}
