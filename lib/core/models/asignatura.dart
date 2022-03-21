import 'package:downmusic/core/models/model.dart';

class Asignatura extends Model {
  final String asignaturaId;
  final String nombre, descripcion, codigo;
  Asignatura(
      {required this.nombre,
      required this.descripcion,
      required this.asignaturaId,
      required this.codigo});

  @override
  Map<String, dynamic> toMap() {
    return {
      "asignaturaId": asignaturaId,
      "nombre": nombre,
      "descripcion": descripcion,
      "codigo": codigo
    };
  }

  @override
  factory Asignatura.fromFirebase(Map<String, dynamic> document) {
    return Asignatura(
      codigo: document['codigo'],
      asignaturaId: document['asignaturaId'],
      nombre: document['nombre'],
      descripcion: document['descripcion'],
    );
  }

  @override
  String getDocumentId() {
    return asignaturaId;
  }
}
