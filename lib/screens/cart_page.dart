import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/product_page.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices firebaseServices = FirebaseServices();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(uid)
                .collection("Cart")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                    body: Center(
                  child: Text("Error ${snapshot.error}"),
                ));
              }
              //if ConnectionState is fine
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return ListView(
                  padding: const EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ProductPage(
                                        productId: document.id,
                                      ))));
                        }),
                        child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection("Products")
                              .doc(document.id)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> productsnap) {
                            if (productsnap.hasError) {}
                            if (productsnap.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              Map<String, dynamic> data = productsnap.data!
                                  .data() as Map<String, dynamic>;
                              dynamic sizeof = document.data();
                              var xx = sizeof['size'];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 2.0),
                                      borderRadius: BorderRadius.circular(7.0)),
                                  width: width / 1,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 90.0,
                                        width: 90.0,
                                        child: ClipRRect(
                                          child: Image.network(
                                            "${data['images'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data['name']}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                "₹${data['price']}",
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Text(
                                              "Size - $xx",
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ).toList(),
                );
              }

              //Loading State
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
