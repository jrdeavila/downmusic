
import 'package:downmusic/core/models/model.dart';

class Usuario extends Model {
  final String nombres, apellidos, telefono;
  String usuarioId;
  final Identificacion identificacion;
  Usuario(
      {required this.nombres,
      required this.apellidos,
      required this.telefono,
      required this.usuarioId,
      required this.identificacion});

  Usuario.fromFirebase(Map<String, dynamic> document)
      : identificacion = Identificacion.fromFirestore(
            document["identificacion"] as Map<String, dynamic>),
        nombres = document["nombres"] as String,
        apellidos = document["apellidos"] as String,
        usuarioId = document["usuarioId"] as String,
        telefono = document["telefono"] as String;

  @override
  Map<String, dynamic> toMap() {
    return {
      "nombres": nombres,
      "apellidos": apellidos,
      "telefono": telefono,
      "usuarioId": usuarioId,
      "identificacion": identificacion.toMap(),
    };
  }

  @override
  String getDocumentId() => usuarioId;

  @override
  set setDocumentId(String documentId) {
    usuarioId = documentId;
  }

  String getRole() => "usuario";
}

class Identificacion {
  final String numero, tipo;
  Identificacion({required this.numero, required this.tipo});

  Identificacion.fromFirestore(Map<String, dynamic> document)
      : tipo = document["tipo"] as String,
        numero = document["numero"] as String;

  Map<String, dynamic> toMap() {
    return {
      "numero": numero,
      "tipo": tipo,
    };
  }
}
