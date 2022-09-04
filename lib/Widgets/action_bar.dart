import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/cart_page.dart';
import 'package:e_commerce_website/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hastitle;
  final bool? hasBackground;
  CustomActionBar(
      {this.title, this.hasBackArrow, this.hastitle, this.hasBackground});

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hastitle = hastitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground
            ? LinearGradient(
                colors: [Colors.white, Colors.white.withOpacity(0)],
                begin: const Alignment(0, 0),
                end: const Alignment(0, 1))
            : null,
      ),
      padding: const EdgeInsets.only(
        top: 56.0,
        left: 28.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow ?? false)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: const Icon(
                  Icons.keyboard_backspace_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          if (_hastitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
                width: 38.0,
                height: 38.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersRef
                      .doc(firebaseServices.getUserId())
                      .collection("Cart")
                      .snapshots(),
                  builder: ((BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    int totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      // List documents = snapshot.data;
                      // Map<String, dynamic> documentData =
                      //     snapshot.data as Map<String, dynamic>;
                      // totalItems = documentData.length;
                      totalItems = snapshot.data!.docs.length;
                      print(totalItems);
                    }

                    return Text("$totalItems",
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white));
                  }),
                )),
          )
        ],
      ),
    );
  }
}


/*
lclhost://login/bharath
100
 */