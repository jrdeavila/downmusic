import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/curso_estudiantes.dart';
import 'package:downmusic/core/models/estudiante.dart';
import 'package:uuid/uuid.dart';

final _firestore = FirebaseFirestore.instance;

class CursoEstudianteFirebase extends ModelFirebase<CursoEstudiante> {
  CursoEstudianteFirebase() : super(nombreColleccion: 'cursos');
  @override
  CursoEstudiante fromFirestore(Map<String, dynamic> document) {
    return CursoEstudiante.fromFirebase(document);
  }

  // Future<void> addEstudiante(Estudiante estudiante) async {
  //   var cursoEstudiantes = await _firestore
  //       .collection(nombreColleccion)
  //       .where('curso', isEqualTo: estudiante.curso.nombre)
  //       .get();
  //   if (cursoEstudiantes.docs.isEmpty) {
  //     var model = CursoEstudiante(
  //       cursoEstudianteid: const Uuid().v4(),
  //       curso: estudiante.curso,
  //       cursoNombre: estudiante.curso.nombre,
  //       estudiantes: [
  //         estudiante,
  //       ],
  //     );
  //     return saveModel(model);
  //   } else {
  //     var curso = await getModel(
  //         cursoEstudiantes.docs.first.data()['cursoEstudianteid']);
  //     curso!.estudiantes
  //         .where((element) => element.usuarioId == estudiante.usuarioId)
  //         .toList();
  //     saveModel(curso);
  //   }
  // }
}
