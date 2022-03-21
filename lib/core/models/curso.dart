import 'package:downmusic/core/models/model.dart';

import 'grado.dart';

class Curso extends Model {
  final String nombre;
  final String cursoId;
  final Grado grado;

  @override
  String getDocumentId() {
    return cursoId;
  }

  Curso({required this.nombre, required this.grado, this.cursoId = ""});

  Curso.fromFirebase(Map<String, dynamic> document)
      : nombre = document['nombre'] as String,
        grado = Grado.fromFirebase(document['grado']),
        cursoId = document['cursoId'] as String;

  @override
  Map<String, dynamic> toMap() {
    return {"nombre": nombre, "cursoId": cursoId, "grado": grado.toMap()};
  }
}
