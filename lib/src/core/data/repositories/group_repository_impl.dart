import 'package:dio/dio.dart';

import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/remote/auth_remote_data_source_impl.dart';
import '../datasources/remote/group_remote_data_source.dart';
import '../datasources/remote/group_remote_data_source_impl.dart';
import '../models/api_group.dart';

final class GroupRepositoryImpl implements IGroupRepository {
  final IGroupRemoteDataSource _groupRemoteDataSource;
  final IAuthRemoteDataSource _authRemoteDataSource;

  GroupRepositoryImpl(Dio dio)
      : _authRemoteDataSource = AuthRemoteDataSourceImpl(dio),
        _groupRemoteDataSource = GroupRemoteDataSourceImpl();

  @override
  Future<void> createGroup(Group group) async {
    final userData = await _authRemoteDataSource.getCurrentUser();
    if (userData == null) throw Exception("User's not found");
    await _groupRemoteDataSource.createGroup(
      ApiGroup(
        groupName: group.groupName,
        groupTheme: group.groupName,
        ownerId: userData.id,
      ),
    );
  }
}
