import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebaseStorageAPI =
      FirebaseStorageAPI(); //Porque tengo que crear la instancia
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageAPI.uploadFile(path, image);
}
