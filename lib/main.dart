import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_cars/screens/login_screen.dart';
import 'package:flutter_cars/screens/user_profile/user_profile_screen.dart';
import 'package:flutter_cars/services/auth.dart';
import 'package:flutter_cars/services/dbService.dart';
import 'package:flutter_cars/wrapper.dart';
import 'package:provider/provider.dart';
import 'Model/car_model.dart';
import 'firebase_options.dart';

void main() async {
  // s'assurer que tout les widgets de flutter son initialise
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      StreamProvider.value(initialData: null, value: AuthService().user),
      StreamProvider<List<Car>>.value(initialData: const [], value: DbService().cars)
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Cars',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
      initialRoute: '/',
      routes: {
        '/': (context)=> const Wrapper(),
        '/profile': (context)=> const UserProfileScreen()
      },
    );
  }
}
