import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/consts/lists.dart';
import 'package:roka_seller/controllers/product_controller.dart';
import 'package:roka_seller/services/firebase_services.dart';
import 'package:roka_seller/views/product_screen/add_product.dart';
import 'package:roka_seller/views/product_screen/edit_product.dart';
import 'package:roka_seller/views/product_screen/item_details.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: 'المنتجات'.text.size(20).make(),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: whiteColor,
        onPressed: () => Get.off(() => const AddProductScreen()),
        tooltip: 'إضافة منتج',
        child: const Icon(Icons.add, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                            Get.to(() => ItemDetails(data: data[index])),
                        tileColor: whiteColor,
                        leading: Image.network(
                          '${data[index]['p_images']}',
                          width: 45,
                        ),
                        title: '${data[index]['p_name']}'
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
                                '${data[index]['p_price']}'
                                    .numCurrency
                                    .toString()
                                    .text
                                    .make(),
                                (context.screenWidth / 30).widthBox,
                                (data[index]['is_featured'] ? 'مميز' : '')
                                    .text
                                    .green500
                                    .make(),
                              ],
                            ),
                            '${data[index]['p_category']}'.text.red500.make(),
                          ],
                        ),
                        trailing: VxPopupMenu(
                          arrowSize: 0,
                          menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuForProduct.length,
                              (i) => Padding(
                                padding: const EdgeInsets.all(10),
                                child: (data[index]['is_featured'] == true &&
                                            i == 0
                                        ? 'إلغاء التمييز'
                                        : popupMenuForProduct[i])
                                    .text
                                    .size(20)
                                    .make()
                                    .onTap(
                                  () {
                                    switch (i) {
                                      case 0:
                                        if (data[index]['is_featured'] ==
                                            true) {
                                          controller
                                              .removeFeatured(data[index].id);
                                        } else {
                                          controller
                                              .addFeatured(data[index].id);
                                        }
                                        break;
                                      case 1:
                                        controller.productNameController.text =
                                            data[index]['p_name'];
                                        controller.categoryNameController.text =
                                            data[index]['p_category'];
                                        controller.productDescriptionController
                                                .text =
                                            data[index]['p_description'];
                                        controller.productQuantityController
                                            .text = data[index]['p_quantity'];
                                        controller.productPriceController.text =
                                            data[index]['p_price'];
                                        Get.to(
                                          () => EditProductScreen(
                                              data: data[index]),
                                        );
                                        break;
                                      case 2:
                                        controller
                                            .deleteProduct(data[index].id);
                                        break;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ).box.white.roundedSM.width(150).make(),
                          clickType: VxClickType.singleClick,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 20, color: whiteColor),
                            ),
                            child: const Icon(Icons.more_vert),
                          ),
                        ),
                      ).box.margin(const EdgeInsets.all(4)).make(),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
