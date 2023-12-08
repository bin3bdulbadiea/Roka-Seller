// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/services/firebase_services.dart';
import 'package:roka_seller/views/orders_screen/order_details.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'الطلبات'.text.size(20).make(),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
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

            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) => ListTile(
                      onTap: () =>
                          Get.to(() => OrdersDetails(data: data[index])),
                      tileColor: whiteColor,
                      // كود الطلب
                      title: '${data[index]['order_code']}'
                          .text
                          .bold
                          .size(18)
                          .maxLines(1)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                      subtitle: intl.DateFormat()
                          .add_yMMMEd()
                          .format(data[index]['order_date'].toDate())
                          .text
                          .color(redColor)
                          .make(),
                      // السعر الإجمالي
                      trailing: '${data[index]['total_amount']}'
                          .numCurrency
                          .toString()
                          .text
                          .semiBold
                          .size(18)
                          .make(),
                    ).box.margin(const EdgeInsets.all(4)).make(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
