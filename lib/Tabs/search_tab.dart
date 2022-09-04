import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/Widgets/custom_input.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FirebaseServices firebaseServices = FirebaseServices();
  String searchString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          if (searchString.isEmpty)
            const Center(
                child: Text(
              "Search Results",
              style: Constants.regularDarkText,
            ))
          else
            FutureBuilder<QuerySnapshot>(
              future: firebaseServices.productsRef
                  .orderBy("search_string")
                  .startAt([searchString]).endAt(["$searchString\uf8ff"]).get(),
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
                      child:
                          CircularProgressIndicator(color: Color(0xFFFF1E00))),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomInput(
              hintText: "Search",
              isPasswordField: false,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    searchString = value.toLowerCase();
                  });
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
