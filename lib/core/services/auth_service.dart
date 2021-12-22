import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../helper/custom_error.dart';

class AuthService {
  AuthService({
    required this.auth,
    this.googleSignIn,
  });

  final FirebaseAuth auth;
  final GoogleSignIn? googleSignIn;

  Stream<User?> get authStateChanges => auth.userChanges();

  User? get userData => auth.currentUser!;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      return CustomError.signInResponse(e.code);
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn!.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      UserCredential result = await auth.signInWithCredential(credential);
      User user = result.user!;

      return user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;

      await auth.currentUser!.sendEmailVerification();

      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      // log(user.uid);
      // return _userFromFirebaseUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      return CustomError.registerResponse(e.code);
    }
  }

  Future signOut() async {
    try {
      if (await googleSignIn!.isSignedIn()) {
        await googleSignIn!.signOut();
      }
      return await auth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future emailVerification() async {
    try {
      return await auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
