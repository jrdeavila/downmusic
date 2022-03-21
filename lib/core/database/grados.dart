import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/grado.dart';


class GradosFirebase extends ModelFirebase<Grado>{
  GradosFirebase() : super(nombreColleccion: 'grados');

  @override
  Grado fromFirestore(Map<String, dynamic> document) {
    return Grado.fromFirebase(document);
  }
  
}
