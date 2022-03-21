import 'package:downmusic/core/database/estudiantes.dart';
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/curso.dart';
import 'package:downmusic/core/models/estudiante.dart';

class CursoFirebase extends ModelFirebase<Curso> {
  CursoFirebase() : super(nombreColleccion: 'cursos');

  @override
  Curso fromFirestore(Map<String, dynamic> document) {
    return Curso.fromFirebase(document);
  }

  Future<void> addEstudiante(Estudiante estudiante) {
    return firestore.runTransaction((transaction) async {
      transaction.set(
          firestore
              .collection(nombreColleccion)
              .doc(estudiante.curso.cursoId)
              .collection('estudiantes')
              .doc(estudiante.usuarioId),
          estudiante.toMap());
      await EstudiantesFirebase().saveModel(estudiante);
    });
  }

  Future<Estudiante?> getEstudiante(String estudianteId) async {
    firestore
        .collection(nombreColleccion)
        .doc()
        .collection('estudiantes')
        .doc(estudianteId);
    var document = await firestore.collection('cursos').doc(estudianteId).get();
    return document.data() != null
        ? Estudiante.fromFirebase(document.data()!)
        : null;
  }

  Stream<List<Estudiante>> getEstudiantes(String cursoId) {
    return firestore
        .collection(nombreColleccion)
        .doc(cursoId)
        .collection('estudiantes')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Estudiante>((doc) => Estudiante.fromFirebase(doc.data()))
            .toList());
  }
}
