import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:o9_memorycard/product_details.dart';
import 'package:path/path.dart';

class FirebaseFunctions {
  String _imageURL;
  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future updateOnFirebase(
      BuildContext context, File _image, ProductDetails productDetails) async {
    if (_image == null) {
      productsCollection
          .doc(productDetails.id)
          .update(productDetails.productDetailsMap);
    } else {
      String fileName = basename(_image.path);
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('products/$fileName');
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(_image);

      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then(
        (String value) {
          _imageURL = productDetails.imageURL;
          String imagePath = productDetails.imagePath;
          print("Done uploading image: $value");
          print('Pahunhgya');
          productDetails.addImageURL(value);
          productDetails.addImagePath(fileName);
          productsCollection
              .doc(productDetails.id)
              .update(productDetails.productDetailsMap);
          firebase_storage.Reference firebaseStorageRef = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('products/$imagePath');
          firebaseStorageRef.delete();
        },
      );
    }
  }

  Future uploadImageToFirebase(
      BuildContext context, File _image, ProductDetails productDetails) async {
    String fileName = basename(_image.path);
    print(_image.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('products/$fileName');

    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

    taskSnapshot.ref.getDownloadURL().then(
      (String value) {
        _imageURL = value;
        print("Done uploading image: $_imageURL");
        print('Pahunhgya');
        productDetails.addImageURL(_imageURL);
        productDetails.addImagePath(fileName);
        addProducts(context, productDetails);
      },
    );
  }

  Future<void> addProducts(
      BuildContext context, ProductDetails productDetails) async {
    return productsCollection.add(productDetails.productDetailsMap);
  }
}
