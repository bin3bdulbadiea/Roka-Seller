import 'package:flutter/material.dart';
import 'package:roka_seller/consts/colors.dart';
import 'package:velocity_x/velocity_x.dart';

Widget homeButton(context, {title, count, image, onTap}) {
  var size = MediaQuery.of(context).size;

  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            '$title'.text.make(),
            '$count'.text.bold.size(16).make(),
          ],
        ),
      ),
      Image.asset('$image', width: 40),
    ],
  )
      .box
      .color(lightGolden)
      .rounded
      .shadowMd
      .size(size.width * 0.4, size.height * 0.1)
      .p8
      .make().onTap(onTap);
}
