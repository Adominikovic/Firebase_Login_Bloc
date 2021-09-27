import 'package:firebase_login/authentication/authentication_bloc.dart';
import 'package:firebase_login/authentication/data/authentication_repository/authentication_repository.dart';
import 'package:firebase_login/authentication/data/providers/firebase_auth_provider.dart';
import 'package:firebase_login/authentication/data/providers/google_sign_in_provider.dart';
import 'package:firebase_login/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'app/observers/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        AuthenticationRepository(
          FirebaseAuthenticationProvider(FirebaseAuth.instance),
          GoogleSignInProvider(GoogleSignIn()),
        ),
      ),
      child: MaterialApp(
        title: 'Google Firebase Login with Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeView(),
      ),
    );
  }
}
