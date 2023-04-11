import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_bread/screens/auth/login_screen.dart';
import 'package:selling_bread/screens/user/user_cart.dart';
import 'package:selling_bread/screens/user/user_products.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:badges/badges.dart' as badges;

import '../../models/branch_model.dart';
import '../../models/products_model.dart';
import 'fetch_products.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Branch> branchesList = [];
  List<String> keyslist = [];
  List<Products> productsList = [];
  List<String> keyslist2 = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBranches();
    fetchProducts();
  }

  void fetchBranches() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("branches");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Branch p = Branch.fromJson(event.snapshot.value);
      branchesList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
       if (mounted) {
        setState(() {});
      }
    });
  }

  void fetchProducts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("products");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Products p = Products.fromJson(event.snapshot.value);
      productsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
       if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var generatedColor = Random().nextInt(Colors.primaries.length);
    Colors.primaries[generatedColor];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            title: Center(child: Text('الصفحة الرئيسية')),
          ),
          drawer: Drawer(
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        height: 200.h,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [.01, .25],
                              colors: [
                                HexColor('#fc6c85'),
                                      HexColor('#f35e93')
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/bag.jpg'),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, UserCart.routeName);
                                },
                                title: Text('سلة المشتريات'),
                                leading: Icon(Icons.shopping_cart),
                              ))),
                      Divider(
                        thickness: 0.8,
                        color: Colors.grey,
                      ),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: Theme.of(context).splashColor,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('تأكيد'),
                                          content: Text(
                                              'هل انت متأكد من تسجيل الخروج'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pushNamed(context,
                                                    LoginScreen.routeName);
                                              },
                                              child: Text('نعم'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('لا'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                title: Text('تسجيل الخروج'),
                                leading: Icon(Icons.exit_to_app_rounded),
                              )))
                    ],
                  ),
                )
                ,
          body: Column(
            children: [
              Image.asset('assets/images/home.jpg'),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text('الفروع',
                      style: TextStyle(
                          color: HexColor('#fc6c85'),
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: branchesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 40.w),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UserProducts(
                                      branchName:
                                          '${branchesList[index].address}',
                                    );
                                  }));
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                ),
                              ),
                              Text('${branchesList[index].address.toString()}'),
                              Text(
                                '${branchesList[index].phoneNumber.toString()}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text('المنتجات',
                      style: TextStyle(
                          color: HexColor('#fc6c85'),
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Container(
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.w, left: 1.w),
                    child: ListView(
                      children: [
                        Container(
                          child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: 11.w,
                              right: 11.w,
                              bottom: 15.h,
                            ),
                            crossAxisCount: 6,
                            itemCount: productsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return FetchProducts(
                                        imageUrl:
                                            '${productsList[index].imageUrl}',
                                        description:
                                            '${productsList[index].description}',
                                        branchName:
                                            '${productsList[index].branchName}',
                                        amount:
                                            productsList[index].amount!.toInt(),
                                        price: '${productsList[index].price}',
                                        productId: '${productsList[index].id}',
                                      );
                                    }));
                                  },
                                  child: Card(
                                    elevation: 0.8,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(),
                                      child: Center(
                                        child: Column(children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        "${productsList[index].imageUrl}"),
                                                  ),
                                                ),
                                              ),
                                              badges.Badge(
                                                badgeContent: Row(
                                                  children: [
                                                    Text(
                                                        '${productsList[index].amount.toString()}'),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: 12,
                                                    )
                                                  ],
                                                ),
                                                badgeStyle: badges.BadgeStyle(
                                                  shape:
                                                      badges.BadgeShape.square,
                                                  badgeColor: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              )
                                            ],
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${productsList[index].name}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${productsList[index].description}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${productsList[index].price} جنيه',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    3, index.isEven ? 5 : 5),
                            mainAxisSpacing: 11.0.h,
                            crossAxisSpacing: 10.0.w,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
