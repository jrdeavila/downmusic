import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/models/model.dart';

abstract class ModelFirebase<T extends Model> {
  final String nombreColleccion;
  final firestore = FirebaseFirestore.instance;

  ModelFirebase({required this.nombreColleccion});

  Future<void> saveModel(T model) {
    return firestore
        .collection(nombreColleccion)
        .doc(model.getDocumentId())
        .set(model.toMap());
  }

  Future<void> deleteModel(String modelId) {
    return firestore.collection(nombreColleccion).doc(modelId).delete();
  }

  Stream<List<T>> getModels() {
    return firestore.collection(nombreColleccion).snapshots().map((snapshot) =>
        snapshot.docs.map<T>((doc) => fromFirestore(doc.data())).toList());
  }

  Stream<T?> getModel(String modelId) async* {
    var document = await firestore
        .collection(nombreColleccion)
        .doc(modelId)
        .snapshots()
        .first;
    if (document.data() == null) yield null;
    yield fromFirestore(document.data()!);
  }

  T fromFirestore(Map<String, dynamic> document);
}
