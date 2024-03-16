import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinnovate/firebase_options.dart';
import 'package:vinnovate/providers/auth_provider.dart';
import 'package:vinnovate/providers/home_provider.dart';
import 'package:vinnovate/screens/home_screen.dart';
import 'package:vinnovate/screens/login_screen.dart';
import 'package:vinnovate/utils/colors_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
