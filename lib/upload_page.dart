import 'dart:io';
import 'package:flutter/material.dart';
import 'package:o9_memorycard/firebase_functions.dart';
import 'package:o9_memorycard/image_picker.dart';
import 'package:o9_memorycard/product_details.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final snackBar = SnackBar(content: Text('Upload complete'));
  var productController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();
  dynamic _image;

  @override
  void dispose() {
    productController.dispose();
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TextFormField(
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
                              print('No image selected.');
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
                              print('No image selected.');
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
                child: _image == null
                    ? Text('No image selected')
                    : Image.file(
                        _image,
                      ),
              ),
              Center(
                child: TextButton(
                  child: Text('Upload'),
                  onPressed: () {
                    ProductDetails productDetails = ProductDetails(
                      productName: productController.text,
                      quantity: int.parse(quantityController.text),
                      price: int.parse(priceController.text),
                    );
                    FirebaseFunctions()
                        .uploadImageToFirebase(context, _image, productDetails)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {
                        productController.clear();
                        quantityController.clear();
                        priceController.clear();
                        _image = null;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
