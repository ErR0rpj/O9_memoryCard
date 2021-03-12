class ProductDetails {
  String id;
  String imageURL;
  String productName;
  int quantity;
  int price;
  Map<String, dynamic> productDetailsMap = Map<String, dynamic>();

  ProductDetails({this.imageURL, this.productName, this.quantity, this.price}) {
    print(imageURL);
    productDetailsMap = {
      'imageURL': this.imageURL,
      'productName': this.productName,
      'quantity': this.quantity,
      'price': this.price,
    };
  }

  void addImageURL(String imgURL) {
    this.imageURL = imgURL;
    productDetailsMap['imageURL'] = this.imageURL;
  }
}
