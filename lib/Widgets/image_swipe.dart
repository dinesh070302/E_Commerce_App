import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  const ImageSwipe({
    Key? key,
    required this.imageList,
  }) : super(key: key);

  final List imageList;

  @override
  State<ImageSwipe> createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (numb) {
              setState(() {
                selectedPage = numb;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                Container(
                  child: Image.network(
                    "${widget.imageList[i]}",
                    fit: BoxFit.fill,
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: 10.0,
                    width: selectedPage == i ? 35.0 : 12.0,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0)),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
