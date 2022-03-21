
import 'package:downmusic/core/models/estudiante.dart';
import 'package:downmusic/core/models/model.dart';

class Asistencia extends Model {
  final String asistenciaId;
  final bool asistio;
  final Estudiante estudiante;

  Asistencia(
      {required this.asistenciaId,
      required this.estudiante,
      required this.asistio});

  @override
  String getDocumentId() {
    return asistenciaId;
  }

  factory Asistencia.fromFirebase(Map<String, dynamic> document) {
    return Asistencia(
        asistenciaId: document['asistenciaId'] as String,
        asistio: document['asistio'] as bool,
        estudiante: Estudiante.fromFirebase(
            document['estudiante'] as Map<String, dynamic>));
  }

  @override
  Map<String, dynamic> toMap() {
    return {'asistenciaId': asistenciaId, 'estudiante': estudiante.toMap()};
  }
}

class Escusado extends Asistencia {
  @override
  // ignore: overridden_fields
  final String asistenciaId;
  @override
  // ignore: overridden_fields
  final Estudiante estudiante;
  final bool asistio;
  final String descripcionEscusa;

  Escusado(
      {required this.asistenciaId,
      required this.estudiante,
      required this.asistio,
      required this.descripcionEscusa})
      : super(
            asistenciaId: asistenciaId,
            estudiante: estudiante,
            asistio: asistio);

  factory Escusado.fromFirebase(Map<String, dynamic> document) {
    return Escusado(
        asistio: document['asistio'] as bool,
        asistenciaId: document['asistenciaId'] as String,
        estudiante: Estudiante.fromFirebase(
            document['estudiante'] as Map<String, dynamic>),
        descripcionEscusa: document['descripcionEscusa'] as String);
  }
  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    map.addAll({
      'descripcionEscusa': descripcionEscusa,
    });

    return map;
  }
}

class ListAsistencia extends Model {
  final DateTime fecha;
  final String listaAsistenciaId;
  final List<Asistencia> asistencias;

  ListAsistencia(
      {required this.fecha,
      required this.listaAsistenciaId,
      required this.asistencias});

  @override
  String getDocumentId() {
    return listaAsistenciaId;
  }

  factory ListAsistencia.fromFirebase(Map<String, dynamic> document) {
    return ListAsistencia(
        fecha: DateTime.parse(document['fecha'] as String),
        listaAsistenciaId: document['listaAsistenciaId'] as String,
        asistencias: (document['asistencias'] as List<Map<String, dynamic>>)
            .map<Asistencia>((asistencia) {
          if (asistencia.containsKey('descripcionEscusa')) {
            return Escusado.fromFirebase(asistencia);
          } else {
            return Asistencia.fromFirebase(asistencia);
          }
        }).toList());
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha.toString(),
      'listaAsistenciaId': listaAsistenciaId,
      'asistencias':
          asistencias.map((asistencia) => asistencia.toMap()).toList()
    };
  }
}
