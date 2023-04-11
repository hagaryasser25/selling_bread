import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:selling_bread/screens/admin/add_branch.dart';
import 'package:selling_bread/screens/admin/admin_bookings.dart';
import 'package:selling_bread/screens/admin/admin_branches.dart';
import 'package:selling_bread/screens/admin/admin_home.dart';
import 'package:selling_bread/screens/auth/admin_login.dart';
import 'package:selling_bread/screens/auth/login_screen.dart';
import 'package:selling_bread/screens/auth/signup_screen.dart';
import 'package:selling_bread/screens/user/user_cart.dart';
import 'package:selling_bread/screens/user/user_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : const UserHome(),
      routes: {
        SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        UserHome.routeName: (ctx) => UserHome(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        AdminBranches.routeName: (ctx) => AdminBranches(),
        AdminBookings.routeName: (ctx) => AdminBookings(),
        AddBranch.routeName: (ctx) => AddBranch(),
        UserCart.routeName: (ctx) => UserCart(),
      },
    );
  }
}
