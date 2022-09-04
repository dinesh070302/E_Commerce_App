import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:e_commerce_website/screens/product_page.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SavedPage extends StatelessWidget {
  final FirebaseServices firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(firebaseServices.getUserId())
                .collection("Saved")
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
                              return const CircularProgressIndicator();
                            } else {
                              dynamic sizeof = document.data();
                              var xx = sizeof['size'];
                              Map<String, dynamic> data = productsnap.data!
                                  .data() as Map<String, dynamic>;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
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
                                      ),
                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     GestureDetector(
                                      //       child: Container(
                                      //         color: Colors.black,
                                      //         height: 10.0,
                                      //         width: 10.0,
                                      //         child: Center(
                                      //           child: Text(
                                      //             "-",
                                      //             style: TextStyle(
                                      //                 color: Colors.white,
                                      //                 fontSize: 8.0,
                                      //                 fontWeight:
                                      //                     FontWeight.w700),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     )
                                      //   ],
                                      // )
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
            title: "Saved",
          ),
        ],
      ),
    );
  }
}
