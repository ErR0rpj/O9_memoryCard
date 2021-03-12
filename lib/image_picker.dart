import 'package:image_picker/image_picker.dart';

class PickImage {
  final picker = ImagePicker();

  Future<PickedFile> getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return pickedFile;
  }

  Future<PickedFile> getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
