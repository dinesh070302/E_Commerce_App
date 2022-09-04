import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/product_page.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<dynamic>(
            future: firebaseServices.usersRef
                .doc(firebaseServices.getUserId())
                .collection("Cart")
                .get(),
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
                      return GestureDetector(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ProductPage(
                                          productId: document.id,
                                        ))));
                          }),
                          child: FutureBuilder<dynamic>(
                            future: firebaseServices.productsRef
                                .doc(document.id)
                                .get(),
                            builder: ((context, productSnap) {
                              Map productMap = productSnap.data!;
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 24.0,
                                ),
                                child: Text(productMap['name']),
                              );
                            }),
                          ));
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
            hasBackArrow: true,
            hastitle: true,
            title: "Cart",
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
