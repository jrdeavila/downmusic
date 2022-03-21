
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/asignatura_docente.dart';

class AsignaturasDocentesFirebase extends ModelFirebase<AsignaturaDocente>{
  AsignaturasDocentesFirebase() : super(nombreColleccion: 'asignaturasDocentes');

  @override
  AsignaturaDocente fromFirestore(Map<String, dynamic> document) {
    return AsignaturaDocente.fromFirestore(document);
  }
}
