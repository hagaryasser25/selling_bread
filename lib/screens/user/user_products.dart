import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selling_bread/models/products_model.dart';
import 'package:selling_bread/screens/user/fetch_products.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class UserProducts extends StatefulWidget {
  String branchName;
  static const routeName = '/userProducts';
  UserProducts({required this.branchName});

  @override
  State<UserProducts> createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Products> productsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchProducts();
  }

  void fetchProducts() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("products");
    base
        .orderByChild("branchName")
        .equalTo("${widget.branchName}")
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      Products p = Products.fromJson(event.snapshot.value);
      productsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Center(
                child: Text('${widget.branchName}',
                    style: TextStyle(color: Colors.black))),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 11.h,
              ),
              Container(
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.w, left: 1.w),
                    child: ListView(
                      scrollDirection: Axis.vertical,
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
                                        imageUrl: '${productsList[index].imageUrl}',
                                        description: '${productsList[index].description}',
                                        branchName: '${productsList[index].branchName}',
                                        amount: productsList[index].amount!.toInt(),
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
