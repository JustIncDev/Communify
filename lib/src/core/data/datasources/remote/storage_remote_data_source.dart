import 'dart:io';

abstract interface class IStorageRemoteDataSource {
  Future<String> uploadFile(File file);
}
