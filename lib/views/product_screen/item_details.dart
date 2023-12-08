import 'package:flutter/material.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'تفاصيل المنتج'.text.size(20).make(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${data['p_images']}',
                width: double.infinity,
                height: context.screenHeight * 0.4,
                fit: BoxFit.contain,
              ),
              (context.screenHeight / 50).heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  '${data['p_name']}'.text.size(18).bold.make(),
                  (context.screenHeight / 50).heightBox,

                  //price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      'السعر :'.text.make(),
                      (context.screenHeight / 50).widthBox,
                      '${data['p_price']}'
                          .toString()
                          .numCurrency
                          .text
                          .color(redColor)
                          .size(18)
                          .bold
                          .make(),
                    ],
                  ),

                  Row(
                    children: [
                      'الكمية :'.text.make(),
                      (context.screenHeight / 50).widthBox,
                      '${data['p_quantity']}'.text.make(),
                    ],
                  ),

                  'وصف المنتج'.text.bold.make(),
                  '${data['p_description']}'.text.make(),
                ],
              ).box.white.p8.roundedSM.make(),
            ],
          ).box.white.padding(const EdgeInsets.all(10)).roundedSM.make(),
        ),
      ),
    );
  }
}
