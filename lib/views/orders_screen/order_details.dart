// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:roka_seller/consts/firebase_const.dart';
import 'package:roka_seller/controllers/orders_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatefulWidget {
  const OrdersDetails({super.key, this.data});
  final dynamic data;

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {
  var controller = Get.put(OrdersController());
  @override
  void initState() {
    super.initState();
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delevery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: 'تفاصيل الطلب'.text.semiBold.size(20).make(),
          centerTitle: true,
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: context.screenHeight * 0.07,
            width: context.screenWidth,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                shape: MaterialStatePropertyAll(BeveledRectangleBorder()),
              ),
              onPressed: () {
                controller.confirmed(true);
                controller.changeStatus(
                  title: 'order_confirmed',
                  status: true,
                  docID: widget.data.id,
                );
              },
              child: 'تأكيد الحجز'.text.white.make(),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              (context.screenHeight / 100).heightBox,
              Visibility(
                visible: controller.confirmed.value,
                child: Column(
                  children: [
                    'حالة الطلب'.text.semiBold.size(18).make(),
                    (context.screenHeight / 100).heightBox,
                    SwitchListTile(
                      activeColor: Colors.green,
                      value: true,
                      onChanged: (value) {},
                      title: 'تم الحجز'.text.make(),
                    ),
                    SwitchListTile(
                      activeColor: Colors.green,
                      value: controller.confirmed.value,
                      onChanged: (value) {
                        controller.confirmed.value = value;
                      },
                      title: 'تأكيد الحجز'.text.make(),
                    ),
                    SwitchListTile(
                      activeColor: Colors.green,
                      value: controller.onDelivery.value,
                      onChanged: (value) {
                        controller.onDelivery.value = value;
                        controller.changeStatus(
                          title: 'order_on_delevery',
                          status: value,
                          docID: widget.data.id,
                        );
                      },
                      title: 'جاري التوصيل'.text.make(),
                    ),
                    SwitchListTile(
                      activeColor: Colors.green,
                      value: controller.delivered.value,
                      onChanged: (value) {
                        controller.delivered.value = value;
                        controller.changeStatus(
                          title: 'order_delivered',
                          status: value,
                          docID: widget.data.id,
                        );
                      },
                      title: 'تم التسليم'.text.make(),
                    ),
                  ],
                )
                    .box
                    .white
                    .roundedSM
                    .margin(const EdgeInsets.symmetric(horizontal: 10))
                    .p16
                    .make(),
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(usersCollection)
                        .where('id', isEqualTo: widget.data['order_by'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return 'لا توجد بيانات'.text.make();
                      } else {
                        var userData = snapshot.data!.docs;

                        return Container(
                          color: Vx.red100,
                          height: context.screenHeight * 0.25,
                          child: Column(
                            children: [
                              'بيانات المشتري'.text.semiBold.size(18).make(),
                              (context.screenHeight / 100).heightBox,
                              Expanded(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: userData.length,
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      'الاسم : ${userData[index]['name']}'
                                          .text
                                          .make(),
                                      'البريد : ${userData[index]['email']}'
                                          .text
                                          .make(),
                                      'الهاتف : ${userData[index]['phone']}'
                                          .text
                                          .make(),
                                      'العنوان : ${userData[index]['address']}'
                                          .text
                                          .make(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                              .box
                              .roundedSM
                              .margin(const EdgeInsets.all(10))
                              .p16
                              .make(),
                        );
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  'معلومات الطلب'.text.semiBold.size(18).make(),
                  (context.screenHeight / 100).heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          'رمز الطلب'.text.semiBold.make(),
                          '${widget.data['order_code']}'
                              .text
                              .color(redColor)
                              .semiBold
                              .make(),
                          (context.screenHeight / 100).heightBox,
                          'تاريخ الطلب'.text.semiBold.make(),
                          intl.DateFormat()
                              .add_yMMMEd()
                              .format(widget.data['order_date'].toDate())
                              .text
                              .color(redColor)
                              .semiBold
                              .make(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 'حالة التسليم'.text.semiBold.make(),
                          // 'تم الحجز'.text.color(redColor).semiBold.make(),
                          // (context.screenHeight / 100).heightBox,
                          'السعر الإجمالي'.text.semiBold.make(),
                          '${widget.data['total_amount']}'
                              .toString()
                              .numCurrency
                              .text
                              .color(redColor)
                              .semiBold
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ],
              ).box.white.roundedSM.p16.make(),
              (context.screenHeight / 100).heightBox,
              Column(
                children: [
                  'المنتج المطلوب'.text.semiBold.size(18).make(),
                  (context.screenHeight / 100).heightBox,
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      widget.data['orders'].length,
                      // 3,
                      (index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.network(
                                  '${widget.data['orders'][index]['image']}',
                                  fit: BoxFit.cover,
                                  width: context.screenWidth / 6,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      '${widget.data['orders'][index]['title']}'
                                          .text
                                          .maxLines(1)
                                          .overflow(TextOverflow.ellipsis)
                                          .semiBold
                                          .make(),
                                      '${widget.data['orders'][index]['quantity']}×'
                                          .text
                                          .color(redColor)
                                          .semiBold
                                          .make(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      'السعر'.text.semiBold.make(),
                                      '${widget.data['orders'][index]['price']}'
                                          .numCurrency
                                          .toString()
                                          .text
                                          .color(redColor)
                                          .semiBold
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            (context.screenHeight / 50).heightBox,
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .margin(const EdgeInsets.symmetric(horizontal: 10))
                  .p16
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
