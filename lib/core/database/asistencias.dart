import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/asistencia.dart';
import 'package:downmusic/core/models/curso_estudiantes.dart';

final _firestore = FirebaseFirestore.instance;

class AsistenciasFirebase extends ModelFirebase<ListAsistencia> {
  final CursoEstudiante cursoEstudiante;
  AsistenciasFirebase({required this.cursoEstudiante})
      : super(nombreColleccion: 'asistencias');

  @override
  Stream<List<ListAsistencia>> getModels() {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.cursoEstudianteid)
        .collection(nombreColleccion)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<ListAsistencia>(
                (doc) => ListAsistencia.fromFirebase(doc.data()))
            .toList());
  }

  @override
  Future<void> saveModel(ListAsistencia model) {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.cursoEstudianteid)
        .collection(nombreColleccion)
        .doc(model.listaAsistenciaId)
        .set(model.toMap());
  }

  @override
  Future<void> deleteModel(String modelId) {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.cursoEstudianteid)
        .collection(nombreColleccion)
        .doc(modelId)
        .delete();
  }

  @override
  ListAsistencia fromFirestore(Map<String, dynamic> document) {
    return ListAsistencia.fromFirebase(document);
  }
}
