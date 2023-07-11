import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/storage_repository.dart';
import '../datasources/remote/storage_remote_data_source.dart';
import '../datasources/remote/storage_remote_data_source_impl.dart';

final class StorageRepositoryImpl implements IStorageRepository {
  final IStorageRemoteDataSource _storageRemoteDataSource;

  StorageRepositoryImpl()
      : _storageRemoteDataSource = StorageRemoteDataSourceImpl();

  @override
  Future<String> uploadFile(XFile file) {
    return _storageRemoteDataSource.uploadFile(File(file.path));
  }
}
