import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/views/request_screen/request_details.dart';
import 'package:velocity_x/velocity_x.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'طلب توفير منتج'.text.size(20).make(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              data.length,
              (index) => ListTile(
                onTap: () => Get.to(
                  () => RequestDetails(data: data[index]),
                ),
                tileColor: whiteColor,
                // صورة الطلب
                leading: Image.network(
                  '${data[index]['image']}',
                  width: 45,
                ),
                title:
                    '${data[index]['description']}'.text.bold.size(18).make(),
              ).box.margin(const EdgeInsets.all(4)).make(),
            ),
          ),
        ),
      ),
    );
  }
}
