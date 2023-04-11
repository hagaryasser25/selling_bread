import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:selling_bread/screens/user/user_home.dart';
import '../../models/users_model.dart';

// ignore: must_be_immutable
class FetchProducts extends StatefulWidget {
  String imageUrl;
  int amount;
  String description;
  String branchName;
  String price;
  String productId;
  FetchProducts(
      {required this.imageUrl,
      required this.amount,
      required this.description,
      required this.branchName,
      required this.price,
      required this.productId});

  @override
  State<FetchProducts> createState() => _FetchProductsState();
}

class _FetchProductsState extends State<FetchProducts> {
  var amountController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print(currentUser.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Column(
            children: [
              Image.network('${widget.imageUrl}'),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        '${widget.description}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('${widget.branchName}',
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('${widget.price} جنيه',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text('الكمية المتاحة : ${widget.amount}',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 5,
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Notice"),
                              content: SizedBox(
                                height: 65.h,
                                child: TextField(
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    fillColor: HexColor('#155564'),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xfff8a55f), width: 2.0),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: 'ادخل الكمية',
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: HexColor('#6bbcba'),
                                  ),
                                  child: Text("اضافة"),
                                  onPressed: () async {
                                    int? price = int.parse(widget.price);
                                    int amount =
                                        int.parse(amountController.text.trim());
                                    int total = price * amount;
                                    String imageUrl =
                                        widget.imageUrl.toString();

                                    if (amount == 0) {
                                      MotionToast(
                                              primaryColor: Colors.blue,
                                              width: 300,
                                              height: 50,
                                              position:
                                                  MotionToastPosition.center,
                                              description: Text('ادخل الكمية'))
                                          .show(context);
                                      return;
                                    }

                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    if (user != null) {
                                      String uid = user.uid;

                                      DatabaseReference companyRef =
                                          FirebaseDatabase.instance
                                              .reference()
                                              .child('cart')
                                              .child(uid);

                                      String? id = companyRef.push().key;

                                      await companyRef.child(id!).set({
                                        'id': id,
                                        'stock': widget.amount,
                                        'productId': widget.productId,
                                        'description': widget.description,
                                        'price': price,
                                        'amount': amount,
                                        'total': total,
                                        'imageUrl': imageUrl,
                                        'branchName': widget.branchName,
                                        'userName': currentUser.fullName,
                                        'userPhone': currentUser.phoneNumber,
                                      });
                                    }

                                    showAlertDialog(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor('#fc6c85'),
                            HexColor('#f35e93')
                          ]),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          constraints: const BoxConstraints(minWidth: 88.0),
                          child: const Text('أضافة الى السلة',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم الأضافة فى سلة المشتريات"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
