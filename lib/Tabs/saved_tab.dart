import 'package:e_commerce_website/Widgets/action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: const [
          Center(
            child: Center(child: Text("SavedTab")),
          ),
          CustomActionBar(
            title: "Saved",
          ),
        ],
      ),
    );
  }
}
