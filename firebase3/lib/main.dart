import 'package:firebase3/auth/home.dart';
import 'package:firebase3/auth/login.dart';
import 'package:firebase3/auth/register.dart';
import 'package:firebase3/category/add.dart';
import 'package:firebase3/firebase_options.dart';
import 'package:firebase3/stream_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    print('Current User: ${FirebaseAuth.instance.currentUser}');
    print('Email Verified: ${FirebaseAuth.instance.currentUser?.emailVerified}');

    print('status of user : ${FirebaseAuth.instance.currentUser}');
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.orange),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[50],
            titleTextStyle: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            iconTheme: IconThemeData(color: Colors.orange)),
      ),
      home: Scaffold(
          body: (FirebaseAuth.instance.currentUser?.emailVerified == true )
              ? HomePage()
              :  Login(),
          // other example :
          // body: FilterFirestore(),

          // body: StreamBuilderExample(),
          ),
      routes: {
        'register': (context) => Register(),
        'login': (context) => Login(),
        'home': (context) => HomePage(),
        'add': (context) => AddElement(),
      },
    );
  }
}
