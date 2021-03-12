import 'package:flutter/material.dart';
import 'package:o9_memorycard/product_page.dart';

class ProductRow extends StatefulWidget {
  final String id;
  final String productName;
  final int price;
  final String imageURL;
  final int quantity;
  final String imagePath;

  ProductRow(
      {this.id,
      this.productName,
      this.imageURL,
      this.price,
      this.quantity,
      this.imagePath});

  @override
  _ProductRowState createState() => _ProductRowState();
}

class _ProductRowState extends State<ProductRow> {
  Image loadedImage;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        height: 100,
        width: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.imageURL != null
              ? loadedImage = Image.network(
                  widget.imageURL,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No Image',
                  style: TextStyle(color: Colors.grey),
                ),
        ),
      ),
      title: Text(
        widget.productName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      subtitle: Text(widget.price.toString()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              id: widget.id,
              productName: widget.productName,
              imageURL: widget.imageURL,
              price: widget.price,
              quantity: widget.quantity,
              loadedImage: loadedImage,
              imagePath: widget.imagePath,
            ),
          ),
        );
      },
    );
  }
}
