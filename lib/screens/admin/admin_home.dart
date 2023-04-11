import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_bread/screens/admin/admin_bookings.dart';
import 'package:selling_bread/screens/admin/admin_branches.dart';
import 'package:selling_bread/screens/auth/login_screen.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: HexColor('#fc6c85'),
          title: Center(child: Text('الصفحة الرئيسية')),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/home.jpg'),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'الخدمات المتاحة',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(top: 20.h, right: 15.w, left: 15.w),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdminBranches.routeName);
                        },
                        child: card('assets/images/bakery.png', 'أضافة فرع')),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AdminBookings.routeName);
                        },
                        child:
                            card('assets/images/donut.png', 'طلبيات الشراء')),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child:
                            card('assets/images/logout.png', 'سجل خروج')),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget card(String url, String text) {
  return Container(
    color: HexColor('#ffffff'),
    child: Card(
      elevation: 0.5,
      color: HexColor('#ffffff'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 150.w,
        height: 250.h,
        child: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Container(width: 130.w, height: 170.h, child: Image.asset(url)),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 18,
              ))
        ]),
      ),
    ),
  );
}
