import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'تفاصيل الطلب'.text.size(20).make(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${data['image']}',
                width: double.infinity,
                height: context.screenHeight * 0.4,
                fit: BoxFit.contain,
              ),
              (context.screenHeight / 50).heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'وصف الطلب'.text.bold.size(20).make(),
                  (context.screenHeight / 50).heightBox,
                  '${data['description']}'.text.make(),
                ],
              ).box.white.p8.roundedSM.make(),
            ],
          ).box.white.padding(const EdgeInsets.all(10)).roundedSM.make(),
        ),
      ),
    );
  }
}
