import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/actividad.dart';
import 'package:downmusic/core/models/curso_estudiantes.dart';


final _firestore = FirebaseFirestore.instance;

class ActividadesFirebase extends ModelFirebase<Actividad> {
  CursoEstudiante cursoEstudiante;
  ActividadesFirebase({required this.cursoEstudiante})
      : super(nombreColleccion: 'actividades');

  @override
  Actividad fromFirestore(Map<String, dynamic> document) {
    return Actividad.fromFirebase(document);
  }

  @override
  Stream<List<Actividad>> getModels() {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.getDocumentId())
        .collection(nombreColleccion)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => fromFirestore(doc.data())).toList());
  }

  @override
  Future<void> saveModel(Actividad model) {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.getDocumentId())
        .collection(nombreColleccion)
        .doc(model.actividadId)
        .set(model.toMap());
  }

  @override
  Future<void> deleteModel(String modelId) {
    return _firestore
        .collection('cursoEstudiantes')
        .doc(cursoEstudiante.getDocumentId())
        .collection(nombreColleccion)
        .doc(modelId)
        .delete();
  }
}
