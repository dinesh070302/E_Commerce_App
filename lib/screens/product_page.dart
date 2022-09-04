import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:e_commerce_website/Widgets/image_swipe.dart';
import 'package:e_commerce_website/Widgets/product_sizes.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductPage extends StatefulWidget {
  final String? productId;
  const ProductPage({this.productId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices firebaseServices = FirebaseServices();

  String selectedSize = "0";

  Future addToCart() {
    return firebaseServices.usersRef
        .doc(firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": selectedSize});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product Added to Cart"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder<dynamic>(
          future: firebaseServices.productsRef.doc(widget.productId).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(
                child: Text("Error ${snapshot.error}"),
              ));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              //Map of document data
              Map<String, dynamic> documentData = snapshot.data.data();

              //List of Images
              List imageList = documentData['images'];
              List productSizes = documentData['size'];
              selectedSize = productSizes[0];

              return ListView(
                padding: EdgeInsets.all(0.0),
                children: [
                  ImageSwipe(imageList: imageList),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 4.0, top: 24.0, left: 24.0, right: 24.0),
                    child: Text(
                      documentData['name'] ?? "Product name",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 24.0),
                    child: Text(
                      "₹${documentData['price']}",
                      style: TextStyle(
                          color: Color(0xFFFF1E00),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    child: Text(
                      documentData['desc'] ?? "Description",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
                    child: Text(
                      "Select Size",
                      style: Constants.regularDarkText,
                    ),
                  ),
                  ProductSizes(
                    productSizes: productSizes,
                    selected: (size) {
                      selectedSize = size;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Container(
                          height: 65.0,
                          width: 65.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDCDCDC),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            size: 32,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await addToCart();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_snackBar);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 16.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              height: 65.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
          hasBackground: false,
          hastitle: false,
        ),
      ],
    ));
  }
}
