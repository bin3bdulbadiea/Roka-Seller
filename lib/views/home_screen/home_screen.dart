// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/consts/firebase_const.dart';
import 'package:roka_seller/services/firebase_services.dart';
import 'package:roka_seller/views/members_screen/members_screen.dart';
import 'package:roka_seller/views/orders_screen/orders_screen.dart';
import 'package:roka_seller/views/product_screen/product_screen.dart';
import 'package:roka_seller/views/report_screen/report_screen.dart';
import 'package:roka_seller/views/request_screen/request_screen.dart';
import 'package:roka_seller/views/suggest_screen/suggest_screen.dart';
import 'package:roka_seller/widgets/home_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: intl.DateFormat('EEE, MMM d, ' 'yy')
            .format(DateTime.now())
            .text
            .size(20)
            .white
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon-512.png', width: 150),
            (context.screenHeight / 100).heightBox,
            'Roka Store'.text.make(),
            (context.screenHeight / 30).heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getProducts(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'المنتجات',
                        count: '${data.length}',
                        image: 'assets/products.png',
                        onTap: () => Get.to(() => const ProductScreen()),
                      );
                    }
                  },
                ),
                // StreamBuilder<QuerySnapshot>(
                //   stream: FirebaseServices.getProducts(),
                //   builder: (context, snapshot) {
                //     if (!snapshot.hasData) {
                //       return const Center(
                //         child: CircularProgressIndicator(
                //           valueColor: AlwaysStoppedAnimation(redColor),
                //         ),
                //       );
                //     } else {
                //       var data = snapshot.data!.docs;

                //       return homeButton(
                //         context,
                //         title: 'الفئات',
                //         count: '${data.length}',
                //         image: 'assets/categories.png',
                //         onTap: () => Get.to(() => const CategoryScreen()),
                //       );
                //     }
                //   },
                // ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getOrders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'طلبات الشراء',
                        count: '${data.length}',
                        image: 'assets/orders.png',
                        onTap: () => Get.to(() => const OrdersScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
            (context.screenHeight / 70).heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getRequests(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'طلب منتج',
                        count: '${data.length}',
                        image: 'assets/request.png',
                        onTap: () => Get.to(() => RequestScreen(data: data)),
                      );
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'الأعضاء',
                        count: '${data.length}',
                        image: 'assets/members.png',
                        onTap: () => Get.to(() => MembersScreen(data: data)),
                      );
                    }
                  },
                ),
              ],
            ),
            (context.screenHeight / 70).heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('reports').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'البلاغات',
                        count: '${data.length}',
                        image: 'assets/report.png',
                        onTap: () => Get.to(() => ReportScreen(data: data)),
                      );
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('suggests').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;

                      return homeButton(
                        context,
                        title: 'الاقتراحات',
                        count: '${data.length}',
                        image: 'assets/suggest.png',
                        onTap: () => Get.to(() => SuggestScreen(data: data)),
                      );
                    }
                  },
                ),
              ],
            ),
            // (context.screenHeight / 70).heightBox,
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           'الحاسبة'.text.size(20).make(),
            //         ],
            //       ),
            //     ),
            //     Image.asset('assets/calculator.png', width: 40),
            //   ],
            // )
            //     .box
            //     .color(lightGolden)
            //     .rounded
            //     .shadowMd
            //     .size(context.screenWidth * 0.4, context.screenHeight * 0.1)
            //     .p8
            //     .make(),
          ],
        ),
      ),
    );
  }
}
