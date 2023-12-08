import 'package:roka_seller/consts/firebase_const.dart';

class FirebaseServices {
  static getUsers() {
    return firestore
        .collection(usersCollection)
        .snapshots();
  }

  static getOrders() {
    return firestore.collection(ordersCollection).where('order_by').snapshots();
  }

  static getRequests() {
    return firestore
        .collection(requestsCollection)
        .where('added_by')
        .snapshots();
  }

  static getProducts() {
    return firestore.collection(productsCollection).snapshots();
  }
}
