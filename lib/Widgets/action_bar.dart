import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hastitle;
  final bool? hasBackground;
  const CustomActionBar(
      {this.title, this.hasBackArrow, this.hastitle, this.hasBackground});

  @override
  Widget build(BuildContext context) {
    bool _hastitle = hastitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    final CollectionReference _usersRef =
        FirebaseFirestore.instance.collection("Users");

    User? _user = FirebaseAuth.instance.currentUser;

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
            Container(
              child: GestureDetector(
                onTap: () {},
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
          Container(
              width: 38.0,
              height: 38.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: StreamBuilder(
                stream:
                    _usersRef.doc(_user?.uid).collection("Cart").snapshots(),
                builder: ((context, snapshot) {
                  int totalItems = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    // List documents = snapshot.data;
                    // totalItems = documents.length;
                  }

                  return Text("$totalItems",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white));
                }),
              ))
        ],
      ),
    );
  }
}
