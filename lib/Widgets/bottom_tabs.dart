// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomTabs extends StatefulWidget {
  final int? selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, required this.tabPressed});

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBtn(
            imagePath: _selectedTab == 0
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomBtn(
            imagePath: _selectedTab == 1
                ? Icon(Icons.search)
                : Icon(Icons.search_rounded),
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomBtn(
            imagePath: _selectedTab == 2
                ? Icon(Icons.bookmark_outlined)
                : Icon(Icons.bookmark_border),
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomBtn(
            selected: _selectedTab == 3 ? true : false,
            imagePath: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomBtn extends StatelessWidget {
  final Icon imagePath;
  final bool selected;
  final Function onPressed;
  BottomBtn(
      {required this.imagePath,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 2.0,
                    color: selected ? Color(0xFFFF1E00) : Colors.transparent))),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Container(
          height: 28.0,
          width: 28.0,
          child: imagePath,
        ),
      ),
    );
  }
}
