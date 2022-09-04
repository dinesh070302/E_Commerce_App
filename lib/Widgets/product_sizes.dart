import 'package:flutter/material.dart';

class ProductSizes extends StatefulWidget {
  const ProductSizes({
    Key? key,
    required this.productSizes,
    this.selected,
  }) : super(key: key);

  final List productSizes;
  final Function(String)? selected;

  @override
  State<ProductSizes> createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  int _selected = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            GestureDetector(
              onTap: () {
                widget.selected!("${widget.productSizes[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                    color: _selected == i
                        ? Color(0xFFFF1E00)
                        : const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                width: 42.0,
                height: 42.0,
                child: Text(
                  "${widget.productSizes[i]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontSize: 16.0),
                ),
              ),
            )
        ],
      ),
    );
  }
}
