import 'dart:io';

import 'package:flutter/material.dart';
import 'package:o9_memorycard/firebase_functions.dart';
import 'package:o9_memorycard/image_picker.dart';
import 'package:o9_memorycard/product_details.dart';

class ProductPage extends StatefulWidget {
  final String id;
  final String productName;
  final int price;
  final String imageURL;
  final int quantity;
  final Image loadedImage;
  final String imagePath;

  ProductPage({
    this.id,
    this.productName,
    this.imageURL,
    this.price,
    this.quantity,
    this.loadedImage,
    this.imagePath,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isEditing = false;
  final snackBar2 = SnackBar(content: Text('Editing...'));
  final snackBar = SnackBar(content: Text('Edited sucessfully'));
  var productController;
  var quantityController;
  var priceController;
  dynamic _image;

  @override
  void initState() {
    super.initState();
    productController = TextEditingController(text: widget.productName);
    priceController = TextEditingController(text: widget.price.toString());
    quantityController =
        TextEditingController(text: widget.quantity.toString());
  }

  @override
  void dispose() {
    productController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  enabled: isEditing,
                  maxLines: 1,
                  controller: productController,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  enabled: isEditing,
                  maxLines: 1,
                  controller: quantityController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    return int.parse(value) > 0
                        ? null
                        : 'Minimum quantity must be 1.';
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  enabled: isEditing,
                  maxLines: 1,
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    return int.parse(value) > 0
                        ? null
                        : 'Minimum price must be 1.';
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          PickImage().getCameraImage().then((value) {
                            _image = value;

                            setState(() {
                              if (_image != null) {
                                _image = File(_image.path);
                              } else {
                                SnackBar(
                                  content: Text('No image Selected'),
                                );
                              }
                            });
                          });
                        },
                        child: Text('Capture Image'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          PickImage().getGalleryImage().then((value) {
                            _image = value;

                            setState(() {
                              if (_image != null) {
                                _image = File(_image.path);
                              } else {
                                SnackBar(
                                  content: Text('No image Selected'),
                                );
                              }
                            });
                          });
                        },
                        child: Text('Find Image'),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: _image == null && widget.loadedImage == null
                      ? Text('No image selected')
                      : (_image == null
                          ? widget.loadedImage
                          : Image.file(
                              _image,
                            )),
                ),
                Center(
                  child: isEditing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              child: Text('Upload'),
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar2);

                                ProductDetails productDetails = ProductDetails(
                                  productName: productController.text,
                                  quantity: int.parse(quantityController.text),
                                  price: int.parse(priceController.text),
                                  imageURL: widget.imageURL,
                                  imagePath: widget.imagePath,
                                  id: widget.id,
                                );

                                FirebaseFunctions()
                                    .updateOnFirebase(
                                        context, _image, productDetails)
                                    .then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {});
                                });
                              },
                            ),
                          ],
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              isEditing = true;
                            });
                          },
                          child: Text('Edit'),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
