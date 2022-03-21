

import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/asignatura.dart';

class AsignaturasFirebase extends ModelFirebase<Asignatura>{
  AsignaturasFirebase() : super(nombreColleccion: 'asignaturas');


  @override
  Asignatura fromFirestore(Map<String, dynamic> document) {
    return  Asignatura.fromFirebase(document);
  }
 
}
