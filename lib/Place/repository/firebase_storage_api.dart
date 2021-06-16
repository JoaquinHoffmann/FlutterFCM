import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageAPI {
  final Reference _storageReference = FirebaseStorage.instance.ref();
  //esto obtiene la referencia que corresponde a la url de la clase anterior

  //Esta de abajo es la que sube, recibe el path y el archivo de imagen
  Future<UploadTask> uploadFile(String path, File image) async {
    // ignore: unused_local_variable
    UploadTask storageUploadTask = _storageReference.child(path).putFile(image);
    //Si estamos manejando un sistema con varias ramas decimos que cada anidacion será un hijo
    // path, directory where to save
    // image, real file to store

    return Future.value(_storageReference.child(path).putFile(image));
  }
}
