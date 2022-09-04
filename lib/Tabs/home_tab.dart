import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  // const HomeTab({Key? key}) : super(key: key);

  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                    body: Center(
                  child: Text("Error ${snapshot.error}"),
                ));
              }
              //if ConnectionState is fine
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: const EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map(
                    (document) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        height: 350,
                        margin: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: Product_card(
                          title: document['name'],
                          imageUrl: document['images'][0],
                          price: "₹${document['price']}",
                          productId: document.id,
                        ),
                      );
                    },
                  ).toList(),
                );
              }

              //Loading State
              return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF1E00))),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
          ),
        ],
      ),
    );
  }
}
