import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downmusic/core/models/docente.dart';
import 'package:downmusic/core/models/estudiante.dart';
import 'package:downmusic/core/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Autenticacion {
  User? getUserLogged() {
    return _auth.currentUser;
  }

  Future<FirebaseApp> inicializarFirebase() async {
    FirebaseApp app = await Firebase.initializeApp();

    try {
      app = await Firebase.initializeApp(
        name: 'secundaryApp',
        options: Firebase.app().options,
      );
    } on FirebaseException catch (e) {
      print(e.toString());
    }

    return app;
  }

  Stream<User?> authenticationState() async* {
    await inicializarFirebase();
    yield* _auth.authStateChanges();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<void> entrar(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> crearUsuario(String email, String password) async {
    var anotherApp = Firebase.app('secundaryApp');
    var authSecundary = FirebaseAuth.instanceFor(app: anotherApp);
    return authSecundary.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> getUserAccount(String email, String password) async {
    var anotherApp = Firebase.app('secundaryApp');
    var authSecundary = FirebaseAuth.instanceFor(app: anotherApp);
    authSecundary.signInWithEmailAndPassword(email: email, password: password);
    return authSecundary.currentUser;
  }

 

  Future<void> deleteUserAccount(String email, String password) async {
    var anotherApp = Firebase.app('secundaryApp');
    var authSecundary = FirebaseAuth.instanceFor(app: anotherApp);
    var credendials = await authSecundary.signInWithEmailAndPassword(
        email: email, password: password);
    return credendials.user!.delete();
  }

  Future<void> updateEmail(String oldEmail, String newEmail, String password){
    return _auth.signInWithEmailAndPassword(email: oldEmail, password: password).then((userCredential){
      userCredential.user!.updateEmail(newEmail);
    });
  }
}
