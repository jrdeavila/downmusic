import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final firebaseApp = FirebaseAuth.instance;
final Future<FirebaseApp> firebaseInitializedApp = Firebase.initializeApp(
    /* options: const FirebaseOptions( */
    /*     apiKey: "AIzaSyDt3bWvKHTof1yw7VCb499bPWmH5t_Qs5o", */
    /*     authDomain: "school-academic-328601.firebaseapp.com", */
    /*     projectId: "school-academic-328601", */
    /*     storageBucket: "school-academic-328601.appspot.com", */
    /*     messagingSenderId: "989371769004", */
    /*     appId: "1:989371769004:web:a854fdda25fe2f1ee3ff09", */
    /*     measurementId: "G-KD7SLL0L99"), */
    );
