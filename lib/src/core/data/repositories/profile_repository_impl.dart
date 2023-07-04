import 'package:intl/intl.dart';

import '../../application/common/widgets/social_media_list_tile.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote/profile_remote_data_source.dart';
import '../datasources/remote/profile_remote_data_source_impl.dart';
import '../models/api_user.dart';

final class ProfileRepositoryImpl implements IProfileRepository {
  final IProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl() : _profileRemoteDataSource = ProfileRemoteDataSourceImpl();

  @override
  Future<void> updateUserProfile(UserDomain user) async {
    await _profileRemoteDataSource.updateUserProfile(
      ApiUser.fromJson(
        <String, Object?>{
          'id': user.id,
          'email': user.email,
          'first_name': user.firstName,
          'last_name': user.lastName,
          'username': user.username,
          // 'date_of_birth': formattedDateString,
          'avatar': user.avatar,
          'bio': user.bio
        },
      ),
    );
  }

  @override
  Future<UserDomain> getUserProfile() async {
    final response = await _profileRemoteDataSource.getUserProfile();
    return UserDomain(
      id: response.id,
      email: response.email,
      firstName: response.firstName,
      lastName: response.lastName,
      username: response.username,
      dateOfBirth: response.dateOfBirth?.toIso8601String(),
      avatar: response.avatar,
      bio: response.bio,
      dateOfRegistration: response.dateOfRegistration?.toIso8601String(),
    );
  }

  @override
  Future<void> addSocialProviders(Map<SocialMediaType, String> providers) async {
    await _profileRemoteDataSource.addSocialProviders(providers);
  }
}
