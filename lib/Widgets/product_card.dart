import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/product_page.dart';
import 'package:flutter/material.dart';

class Product_card extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? price;
  final String? productId;

  const Product_card({
    Key? key,
    this.imageUrl,
    this.title,
    this.price,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ProductPage(
                      productId: productId,
                    ))));
      },
      child: Stack(
        children: [
          Container(
            height: 350,
            width: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl ?? "Not Found",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 20.0,
            right: 35.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? "Product",
                  style: Constants.regularHeading,
                ),
                Text(
                  price ?? "Price",
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFFF1E00),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
