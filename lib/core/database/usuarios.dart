import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/database/firebase.dart';
import 'package:downmusic/core/models/usuario.dart';

abstract class UsuariosFirebase<T extends Usuario> extends ModelFirebase<T> {
  final _firebase = FirebaseFirestore.instance;
  final String role;
  UsuariosFirebase({required this.role}) : super(nombreColleccion: 'usuarios');

  @override
  T fromFirestore(Map<String, dynamic> document);

  @override
  Stream<List<T>> getModels() {
    return _firebase.collection(nombreColleccion).snapshots().map((snapshot) {
      return snapshot.docs.where((element) {
        return element.data()['role'] == role;
      }).map((document) {
        return fromFirestore(document.data());
      }).toList();
    });
  }

}
