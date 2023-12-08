import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/controllers/product_controller.dart';
import 'package:roka_seller/views/product_screen/product_screen.dart';
import 'package:roka_seller/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var formKey = GlobalKey<FormState>();

  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: 'إضافة منتج جديد'.text.size(20).make(),
          centerTitle: true,
        ),

        //-------------------

        bottomNavigationBar: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              )
            : ElevatedButton(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(BeveledRectangleBorder()),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      controller.isLoading(true);
                      await controller.uploadImage();
                      await controller.uploadProduct(
                        img: controller.imageLink,
                      );
                      Get.off(() => const ProductScreen());
                    } catch (e) {
                      controller.isLoading(false);

                      VxToast.show(context, msg: 'يجب إضافة صورة');
                    }
                  }
                },
                child: 'نشر'.text.size(20).white.make(),
              ),

        //-------------------

        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  controller.imagePath.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          maxRadius: 70,
                          child: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        )
                      : Container(
                          width: context.screenWidth / 2,
                          height: context.screenHeight / 5,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Image.file(
                            File(controller.imagePath.value),
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                        ),
                  (context.screenHeight / 100).heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                'الكاميرا'.text.make(),
                              ],
                            ),
                          ),
                          Image.asset('assets/camera.png', width: 40),
                        ],
                      )
                          .box
                          .color(lightGolden)
                          .rounded
                          .size(size.width * 0.4, size.height * 0.07)
                          .p8
                          .make()
                          .onTap(
                            () => controller.pickImageFormCamera(context),
                          ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                'المعرض'.text.make(),
                              ],
                            ),
                          ),
                          Image.asset('assets/gallery.png', width: 40),
                        ],
                      )
                          .box
                          .color(lightGolden)
                          .rounded
                          .size(size.width * 0.4, size.height * 0.07)
                          .p8
                          .make()
                          .onTap(
                            () => controller.pickImageFormGallery(context),
                          ),
                    ],
                  ),
                  (context.screenHeight / 50).heightBox,
                  customTextField(
                    controller: controller.productNameController,
                    hint: 'اسم المنتج',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'قم بملء الحقل';
                      }
                      return null;
                    },
                  ),
                  (context.screenHeight / 50).heightBox,
                  customTextField(
                    controller: controller.categoryNameController,
                    hint: 'اسم الفئة',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'قم بملء الحقل';
                      }
                      return null;
                    },
                  ),
                  (context.screenHeight / 50).heightBox,
                  TextFormField(
                    controller: controller.productDescriptionController,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'وصف المنتج',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  (context.screenHeight / 50).heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: customTextField(
                          controller: controller.productQuantityController,
                          hint: 'الكمية المتوفرة',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'قم بملء الحقل';
                            }
                            return null;
                          },
                        ),
                      ),
                      (context.screenWidth / 30).widthBox,
                      Expanded(
                        child: customTextField(
                          controller: controller.productPriceController,
                          hint: 'سعر المنتج',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'قم بملء الحقل';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ).box.white.roundedSM.p8.make(),
            ),
          ),
        ),
      ),
    );
  }
}
