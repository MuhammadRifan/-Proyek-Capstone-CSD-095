import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// import 'core/injection/injection.dart' as di;
import 'core/services/auth_service.dart';
import 'core/services/storage_service.dart';
import 'core/services/user_db_service.dart';
import 'screens/screen_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWrapper(
      child: MaterialApp(
        title: 'Petto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ScreenWrapper(),
      ),
    );
  }
}

class ProviderWrapper extends StatelessWidget {
  const ProviderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // User Authentication
        Provider<AuthService>(
          create: (_) => AuthService(
            auth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
          ),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
        // User Database
        Provider<UserDatabaseService>(
          create: (_) => UserDatabaseService(
            userCollection: FirebaseFirestore.instance.collection('users'),
          ),
        ),
        // Storage
        Provider<StorageService>(
          create: (_) => StorageService(
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: child,
    );
  }
}
