import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<File?> selectPicture() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    return _convertToFile(image);
  }

  Future<File?> takePicture() async {
    final XFile? photo =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) {
      return null;
    }
    return _convertToFile(photo);
  }

  File _convertToFile(XFile xFile) {
    return File(xFile.path);
  }
}
