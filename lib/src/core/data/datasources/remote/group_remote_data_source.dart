import '../../models/api_group.dart';

abstract interface class IGroupRemoteDataSource {
  Future<void> createGroup(ApiGroup group);
}
