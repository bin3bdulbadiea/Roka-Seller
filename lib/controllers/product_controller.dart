// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roka_seller/consts/firebase_const.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var productNameController = TextEditingController();

  var categoryNameController = TextEditingController();

  var productDescriptionController = TextEditingController();

  var productQuantityController = TextEditingController();

  var productPriceController = TextEditingController();

  var isLoading = false.obs;

  var imagePath = ''.obs;

  var imageLink = '';

  pickImageFormCamera(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (img == null) return;
      imagePath.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  pickImageFormGallery(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (img == null) return;
      imagePath.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    var fileName = basename(imagePath.value);
    var destination = 'products/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink = await ref.getDownloadURL();
  }

  uploadProduct({context, required img, docID}) async {
    var store = firestore.collection(productsCollection).doc(docID);
    await store.set({
      'featured_id': docID,
      'is_featured': false,
      'p_category': categoryNameController.text,
      'p_description': productDescriptionController.text,
      'p_images': img,
      'p_name': productNameController.text,
      'p_price': productPriceController.text,
      'p_quantity': productQuantityController.text,
      'p_wishlist': FieldValue.arrayUnion([]),
    });

    isLoading(false);
  }

  addFeatured(docID) async {
    await firestore.collection(productsCollection).doc(docID).set({
      'featured_id': docID,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docID) async {
    await firestore.collection(productsCollection).doc(docID).set({
      'featured_id': docID,
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  deleteProduct(docID) async {
    await firestore.collection(productsCollection).doc(docID).delete();
  }
}
