import 'package:image_picker/image_picker.dart';

abstract interface class IStorageRepository {
  Future<String> uploadFile(XFile file);
}
