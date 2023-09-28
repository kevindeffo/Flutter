import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Connexion avec Google
  Future<UserCredential> signinWithGoogle() async {
    // Declancher le flux d'authentification
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // obtenir les details d'autorisation de la demande
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut()async{
    print("--------- Google signOut ------------");
    await _googleSignIn.signOut();
    print("--------- Firebase signOut ------------");
    await _auth.signOut();
  }

  // Etat de l'utilisateur en temps reel
  Stream<User?> get user => _auth.authStateChanges();
}
