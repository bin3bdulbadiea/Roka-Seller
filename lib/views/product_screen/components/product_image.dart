import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImage({required label, onPressed}) => '$label'
    .text
    .makeCentered()
    .box
    .white
    .shadowMd
    .size(100, 100)
    .roundedSM
    .make();
