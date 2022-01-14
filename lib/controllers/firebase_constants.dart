import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final firebaseApp = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitializedApp = Firebase.initializeApp();
