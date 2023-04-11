import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';
import 'package:selling_bread/screens/admin/admin_home.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/adminLogin';
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            backgroundColor: HexColor('#fc6c85'),
            body: Column(children: [
              SizedBox(
                height: 50.h,
              ),
              Center(child: Image.asset('assets/images/bag.jpg')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 380.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 65.h,
                                child: TextField(
                                  style: TextStyle(color: HexColor('#878787')),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: HexColor('#878787'),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: HexColor('#878787'),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: HexColor('#878787')),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'البريد الألكترونى',
                                    hintStyle: TextStyle(
                                      color: HexColor('#878787'),
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 65.h,
                                child: TextField(
                                  style: TextStyle(color: HexColor('#878787')),
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.password,
                                      color: HexColor('#878787'),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 1.0,
                                        color: HexColor('#878787'),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          width: 1.0,
                                          color: HexColor('#878787')),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'كلمة المرور',
                                    hintStyle: TextStyle(
                                      color: HexColor('#878787'),
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0.0),
                                  elevation: 5,
                                ),
                                onPressed: () async {
                                  var email = emailController.text.trim();
                                  var password = passwordController.text.trim();

                                  if (email.isEmpty || password.isEmpty) {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("please fill all fields"))
                                        .show(context);

                                    return;
                                  }

                                  if (email != 'admin@gmail.com') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                                  if (password != '123456789') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                                  ProgressDialog progressDialog =
                                      ProgressDialog(context,
                                          title: Text('Logging In'),
                                          message: Text('Please Wait'));
                                  progressDialog.show();

                                  try {
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    UserCredential userCredential =
                                        await auth.signInWithEmailAndPassword(
                                            email: email, password: password);

                                    if (userCredential.user != null) {
                                      progressDialog.dismiss();
                                      Navigator.pushNamed(
                                          context, AdminHome.routeName);
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    progressDialog.dismiss();
                                    if (e.code == 'user-not-found') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description:
                                                  Text("user not found"))
                                          .show(context);

                                      return;
                                    } else if (e.code == 'wrong-password') {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text(
                                                  "wrong email or password"))
                                          .show(context);

                                      return;
                                    }
                                  } catch (e) {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("something went wrong"))
                                        .show(context);

                                    progressDialog.dismiss();
                                  }
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(colors: [
                                      HexColor('#fc6c85'),
                                      HexColor('#f35e93')
                                    ]),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    constraints:
                                        const BoxConstraints(minWidth: 250.0),
                                    child: const Text('سجل دخول',
                                        style: TextStyle(color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
