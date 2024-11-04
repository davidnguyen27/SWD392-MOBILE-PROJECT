import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class StorageService with ChangeNotifier {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool _isUploading = false;

  bool get isUploading => _isUploading;

  Future<String?> uploadImage(File file, String fileName) async {
    _isUploading = true;
    notifyListeners();

    try {
      final storageRef = firebaseStorage.ref().child('images/$fileName');
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
      notifyListeners();
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  String extractPathFromUrl(String url) {
    final RegExp regExp = RegExp(r'images%2F(.*?)\?');
    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount > 0) {
      return 'images/${Uri.decodeFull(match.group(1)!)}';
    }
    throw Exception('Invalid URL format');
  }
}
