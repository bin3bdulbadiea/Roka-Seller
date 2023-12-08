import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:roka_seller/consts/firebase_const.dart';

class OrdersController extends GetxController {
  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(ordersCollection).doc(docID);

    await store.set({title: status}, SetOptions(merge: true));
  }
}
