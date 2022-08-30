import 'package:collegebazzar/providers/filterProvider.dart';
import 'package:collegebazzar/screens/admin/product_approval.dart';
import 'package:collegebazzar/screens/auth/signup_screen.dart';
import 'package:collegebazzar/screens/slpashScreen.dart';
import 'package:collegebazzar/screens/user/chatroom.dart';
import 'package:collegebazzar/screens/user/home_screen.dart';
import 'package:collegebazzar/screens/user/product_view.dart';
import 'package:collegebazzar/screens/user/uploadForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/login_screen.dart';
import 'screens/user/search_results.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAHbzipdx44P0gXoEQxZi8HibeRRHonzhg",
      authDomain: "college-bazzar-61258.firebaseapp.com",
      projectId: "college-bazzar-61258",
      storageBucket: "college-bazzar-61258.appspot.com",
      messagingSenderId: "116013204563",
      appId: "1:116013204563:web:306aa35d65a4e6b6c8f2a6",
      measurementId: "G-R9HLS7ZZ9G",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFirebase();
  }

  void setFirebase() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAHbzipdx44P0gXoEQxZi8HibeRRHonzhg",
        authDomain: "college-bazzar-61258.firebaseapp.com",
        projectId: "college-bazzar-61258",
        storageBucket: "college-bazzar-61258.appspot.com",
        messagingSenderId: "116013204563",
        appId: "1:116013204563:web:306aa35d65a4e6b6c8f2a6",
        measurementId: "G-R9HLS7ZZ9G",
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: FilterProvider())],
      child: MaterialApp(
        title: 'College Bazzar',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
