import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({
    required this.auth,
  });

  final FirebaseAuth auth;

  // UserModel _userFromFirebaseUser(User user) {
  //   return UserModel(uid: user.uid);
  // }

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      // log(user.uid);
      // return _userFromFirebaseUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      // log(e.message!);
      return e.message;
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
