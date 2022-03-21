
import 'package:downmusic/core/database/usuarios.dart';
import 'package:downmusic/core/models/estudiante.dart';

class EstudiantesFirebase extends UsuariosFirebase<Estudiante> {
  EstudiantesFirebase() : super(role:  'estudiante');

  @override
  Estudiante fromFirestore(Map<String, dynamic> document) {
    return Estudiante.fromFirebase(document);
  }
  
  /* @override */
  /* Future<void> saveModel(Estudiante model) async { */
  /*   var cursoEstudiantes = CursoEstudianteFirebase(); */
  /*   await cursoEstudiantes.addEstudiante(model); */
  /*   return super.saveModel(model); */
  /* } */
}
