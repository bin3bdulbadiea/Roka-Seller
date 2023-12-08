import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/consts/lists.dart';
import 'package:roka_seller/services/firebase_services.dart';
import 'package:roka_seller/views/product_screen/item_details.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '${data['category_name']}'.text.size(20).make(),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseServices.getProducts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var categoryData = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Get.to(
                      () => ItemDetails(data: categoryData[index]),
                    ),
                    tileColor: whiteColor,
                    leading: Image.network(
                      '${categoryData[index]['c_products']['p_images'][0]}',
                      width: 45,
                    ),
                    title: '${categoryData[index]['c_products']['p_name']}'
                        .text
                        .bold
                        .size(18)
                        .maxLines(1)
                        .overflow(TextOverflow.ellipsis)
                        .make(),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            '${categoryData[index]['c_products']['p_price']}'
                                .numCurrency
                                .toString()
                                .text
                                .make(),
                            (context.screenWidth / 30).widthBox,
                            'مميز'.text.green500.make(),
                          ],
                        ),
                      ],
                    ),
                    trailing: VxPopupMenu(
                      arrowSize: 0,
                      menuBuilder: () => Column(
                        children: List.generate(
                          popupMenuForProduct.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: popupMenuForProduct[index].text.make(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).box.white.roundedSM.width(80).make(),
                      clickType: VxClickType.singleClick,
                      child: const Icon(Icons.more_vert),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
