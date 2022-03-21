
import 'package:downmusic/core/models/asignatura_asignada.dart';
import 'package:downmusic/core/models/model.dart';
import 'package:downmusic/core/models/usuario.dart';

class AsignaturaDocente extends Model {
  final String asignaturaDocenteId, nombreDocente, apellidoDocente;
  final Identificacion identificacionDocente;
  final List<AsignaturaAsignada> asignaturasDocente;

  AsignaturaDocente(
      {required this.asignaturaDocenteId,
      required this.nombreDocente,
      required this.apellidoDocente,
      required this.identificacionDocente,
      required this.asignaturasDocente});

  factory AsignaturaDocente.fromFirestore(Map<String, dynamic> document){
    return AsignaturaDocente(
      asignaturaDocenteId: document['asignaturaDocenteid'],
      nombreDocente: document['nombreDocente'],
      apellidoDocente: document['apellidoDocente'],
      asignaturasDocente: (document['asignaturasAsignadas'] as List)
          .map<AsignaturaAsignada>((asignatura) => AsignaturaAsignada.fromFirestore(asignatura))
          .toList(),
      identificacionDocente: Identificacion.fromFirestore(document['identificacionDocente'])
    );
  }

  @override
  Map<String, dynamic> toMap(){
    return {
      "asignaturaDocenteid": asignaturaDocenteId,
      "nombreDocente": nombreDocente,
      "apellidoDocente": apellidoDocente,
      "identificacionDocente": identificacionDocente.toMap(),
      "asignaturasAsignadas": asignaturasDocente.map((asignatura) => asignatura.toMap()).toList()
    };
  }

  @override
    String getDocumentId() {
      return asignaturaDocenteId;
    }

}
