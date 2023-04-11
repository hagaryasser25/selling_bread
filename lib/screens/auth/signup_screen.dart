import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signupScreen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
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
                      height: 500.h,
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
                            'أنشاء حساب',
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
                                      style: TextStyle(),
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.text_fields,
                                          color: HexColor('#878787'),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: HexColor('#878787'),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: HexColor('#878787')),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: 'الأسم',
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
                                      style:
                                          TextStyle(color: HexColor('#878787')),
                                      controller: phoneNumberController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: HexColor('#878787'),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: HexColor('#878787'),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: HexColor('#878787')),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: 'رقم الهاتف',
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
                                      style:
                                          TextStyle(color: HexColor('#878787')),
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: HexColor('#878787'),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: HexColor('#878787'),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                      style:
                                          TextStyle(color: HexColor('#878787')),
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.password,
                                          color: HexColor('#878787'),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide(
                                            width: 1.0,
                                            color: HexColor('#878787'),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                      var name = nameController.text.trim();
                                      var phoneNumber =
                                          phoneNumberController.text.trim();
                                      var email = emailController.text.trim();
                                      var password =
                                          passwordController.text.trim();

                                      if (name.isEmpty ||
                                          email.isEmpty ||
                                          password.isEmpty ||
                                          phoneNumber.isEmpty) {
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text(
                                                    "please fill all fields"))
                                            .show(context);

                                        return;
                                      }

                                      if (password.length < 6) {
                                        // show error toast
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text(
                                                    "Weak Password, at least 6 characters are required"))
                                            .show(context);

                                        return;
                                      }

                                      ProgressDialog progressDialog =
                                          ProgressDialog(context,
                                              title: Text('Signing Up'),
                                              message: Text('Please Wait'));
                                      progressDialog.show();

                                      try {
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;

                                        UserCredential userCredential =
                                            await auth
                                                .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );

                                        if (userCredential.user != null) {
                                          DatabaseReference userRef =
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('users');

                                          String uid = userCredential.user!.uid;
                                          int dt = DateTime.now()
                                              .millisecondsSinceEpoch;

                                          await userRef.child(uid).set({
                                            'name': name,
                                            'email': email,
                                            'password': password,
                                            'uid': uid,
                                            'dt': dt,
                                            'phoneNumber': phoneNumber,
                                          });

                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;
                                        } else {
                                          MotionToast(
                                                  primaryColor: Colors.blue,
                                                  width: 300,
                                                  height: 50,
                                                  position: MotionToastPosition
                                                      .center,
                                                  description: Text("failed"))
                                              .show(context);
                                        }
                                        progressDialog.dismiss();
                                      } on FirebaseAuthException catch (e) {
                                        progressDialog.dismiss();
                                        if (e.code == 'email-already-in-use') {
                                          MotionToast(
                                                  primaryColor: Colors.blue,
                                                  width: 300,
                                                  height: 50,
                                                  position: MotionToastPosition
                                                      .center,
                                                  description: Text(
                                                      "email is already exist"))
                                              .show(context);
                                        } else if (e.code == 'weak-password') {
                                          MotionToast(
                                                  primaryColor: Colors.blue,
                                                  width: 300,
                                                  height: 50,
                                                  position: MotionToastPosition
                                                      .center,
                                                  description:
                                                      Text("password is weak"))
                                              .show(context);
                                        }
                                      } catch (e) {
                                        progressDialog.dismiss();
                                        MotionToast(
                                                primaryColor: Colors.blue,
                                                width: 300,
                                                height: 50,
                                                position:
                                                    MotionToastPosition.center,
                                                description: Text(
                                                    "something went wrong"))
                                            .show(context);
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
                                        constraints: const BoxConstraints(
                                            minWidth: 250.0),
                                        child: const Text('أنشاء حساب',
                                            style:
                                                TextStyle(color: Colors.white),
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
                ]))));
  }
}
