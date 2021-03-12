class ProductDetails {
  String id;
  String imageURL;
  String productName;
  int quantity;
  int price;
  String imagePath;
  Map<String, dynamic> productDetailsMap = Map<String, dynamic>();

  ProductDetails(
      {this.imageURL,
      this.productName,
      this.quantity,
      this.price,
      this.id,
      this.imagePath}) {
    productDetailsMap = {
      'imageURL': this.imageURL,
      'productName': this.productName,
      'quantity': this.quantity,
      'price': this.price,
      'id': this.id,
      'imagePath': this.imagePath,
    };
  }

  void addImageURL(String imgURL) {
    this.imageURL = imgURL;
    productDetailsMap['imageURL'] = this.imageURL;
  }

  void addImagePath(String imagePath) {
    this.imagePath = imagePath;
    productDetailsMap['imagePath'] = this.imagePath;
  }
}
