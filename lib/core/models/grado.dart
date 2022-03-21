
import 'package:downmusic/core/models/asignatura.dart';
import 'package:downmusic/core/models/model.dart';

class Grado extends Model {
  final String nombre;
  final String gradoId;
  final List<Asignatura> asignaturas;

  Grado(
      {required this.nombre, required this.gradoId, required this.asignaturas});

  Grado.fromFirebase(Map<String, dynamic> document)
      : nombre = document["nombre"] as String,
        gradoId = document["gradoId"] as String,
        asignaturas = (document["asignaturas"] as List<dynamic>)
            .map<Asignatura>((e) => Asignatura.fromFirebase(e))
            .toList();

  @override
  Map<String, dynamic> toMap() {
    return {
      "nombre": nombre,
      "gradoId": gradoId,
      "asignaturas": asignaturasToMap(),
    };
  }

  @override
  String getDocumentId() {
    return gradoId;
  }

  List<Map<String, dynamic>> asignaturasToMap() {
    return asignaturas
        .map<Map<String, dynamic>>(
            (Asignatura asignatura) => asignatura.toMap())
        .toList();
  }
}
