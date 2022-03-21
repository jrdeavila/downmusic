import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/database/asignaturas_docentes.dart';
import 'package:downmusic/core/database/usuarios.dart';
import 'package:downmusic/core/models/asignatura_docente.dart';
import 'package:downmusic/core/models/docente.dart';

final _firestore = FirebaseFirestore.instance;

class DocentesFirebase extends UsuariosFirebase<Docente> {
  DocentesFirebase() : super(role: 'docente');

  @override
  Docente fromFirestore(Map<String, dynamic> document) {
    return Docente.fromFirebase(document);
  }

  @override
  Future<void> saveModel(Docente model) async {
    AsignaturaDocente asignaturas = AsignaturaDocente(
      nombreDocente: model.nombres,
      apellidoDocente: model.apellidos,
      identificacionDocente: model.identificacion,
      asignaturasDocente: model.asignaturas,
      asignaturaDocenteId: model.getDocumentId(),
    );

    await AsignaturasDocentesFirebase().saveModel(asignaturas);

    return super.saveModel(model);
  }
}
