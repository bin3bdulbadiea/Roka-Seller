// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:roka_seller/consts/colors.dart';
// import 'package:roka_seller/consts/lists.dart';
// import 'package:roka_seller/services/firebase_services.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: 'الفئات'.text.size(20).make(),
//         centerTitle: true,
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   tooltip: 'إضافة فئة',
//       //   child: Image.asset('assets/add.png', width: 25),
//       // ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseServices.getProducts(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation(redColor),
//                 ),
//               );
//             } else {
//               var data = snapshot.data!.docs;

//               return Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     children: List.generate(
//                       data.length,
//                       (index) => ListTile(
//                         onTap: () {},
//                         tileColor: whiteColor,
//                         // leading: Image.network('${data[index]['']}', width: 45),
//                         title: '${data[index]['p_category']}'
//                             .text
//                             .bold
//                             .size(18)
//                             .maxLines(1)
//                             .overflow(TextOverflow.ellipsis)
//                             .make(),
//                         // subtitle: 'المنتجات: ${data[index]['']}'.text.make(),
//                         trailing: VxPopupMenu(
//                           arrowSize: 0,
//                           menuBuilder: () => Column(
//                             children: List.generate(
//                               popupMenuForCategory.length,
//                               (index) => Padding(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {},
//                                       child: popupMenuForCategory[index]
//                                           .text
//                                           .make(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ).box.white.roundedSM.width(80).make(),
//                           clickType: VxClickType.singleClick,
//                           child: const Icon(Icons.more_vert),
//                         ),
//                       ).box.margin(const EdgeInsets.all(4)).make(),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }),
//     );
//   }
// }
