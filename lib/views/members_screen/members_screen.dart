import 'package:flutter/material.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'الأعضاء'.text.size(20).make(),
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
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          'الاسم: ${data[index]['name']}'.text.make(),
                          'البريد: ${data[index]['email']}'.text.make(),
                          'الهاتف: ${data[index]['phone']}'.text.make(),
                          'العنوان: ${data[index]['address']}'.text.make(),
                          'كلمة المرور: ${data[index]['password']}'.text.make(),
                        ],
                      ),
                    ),
                  ),
                ),
                tileColor: whiteColor,
                title: '${data[index]['name']}'.text.bold.size(18).make(),
                subtitle: '${data[index]['email']}'.text.make(),
              ).box.margin(const EdgeInsets.all(4)).make(),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
