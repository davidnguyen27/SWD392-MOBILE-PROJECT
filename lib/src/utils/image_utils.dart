import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class ImageUtils {
  final picker = ImagePicker();

  // Hàm chọn ảnh từ thư viện
  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  // Hàm upload ảnh lên Firebase Storage
  Future<String?> uploadImageToFirebase(File image) async {
    try {
      String fileName = basename(image.path); // Lấy tên file
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Lấy URL của ảnh đã upload
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      return null;
    }
  }
}
