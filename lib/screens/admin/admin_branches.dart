import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selling_bread/screens/admin/add_branch.dart';
import 'package:selling_bread/screens/admin/add_product.dart';
import 'package:selling_bread/screens/admin/admin_products.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/branch_model.dart';

class AdminBranches extends StatefulWidget {
  static const routeName = '/adminBranches';
  const AdminBranches({super.key});

  @override
  State<AdminBranches> createState() => _AdminBranchesState();
}

class _AdminBranchesState extends State<AdminBranches> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Branch> branchesList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBranches();
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
              color: Colors.white, //change your color here
            ),
            backgroundColor: HexColor('#fc6c85'),
            title: Center(
                child: Text('الفروع', style: TextStyle(color: Colors.white))),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor('#fc6c85'),
            onPressed: () {
              Navigator.pushNamed(context, AddBranch.routeName);
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // circular shape
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
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
                            itemCount: branchesList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0.2,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(color: Colors.grey)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w, left: 10.w),
                                      child: Center(
                                        child: Column(children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Image.asset(
                                              'assets/images/branch.jpg',
                                              height: 100.h),
                                          FittedBox(
                                            fit: BoxFit.fitWidth,
                                            child: Text(
                                              '${branchesList[index].address}',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 170.w, height: 45.h),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    HexColor('#f35e93'),
                                              ),
                                              child: Text('أضافة منتجات',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                      color: Colors.white)),
                                              onPressed: () async {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return AddProduct(
                                                    branchAddress:
                                                        '${branchesList[index].address}',
                                                  );
                                                }));
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 170.w, height: 45.h),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    HexColor('#f35e93'),
                                              ),
                                              child: Text('عرض المنتجات',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                      color: Colors.white)),
                                              onPressed: () async {
                                                
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return AdminProducts(
                                                    branchName: '${branchesList[index].address}',
                                                  );
                                                }));
                                                
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('branches')
                                                  .child(
                                                      '${branchesList[index].id}')
                                                  .remove();
                                            },
                                            child: Icon(Icons.delete,
                                                color: Color.fromARGB(
                                                    255, 122, 122, 122)),
                                          )
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
