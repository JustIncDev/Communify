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
          'user_name': user.username,
          'date_of_birth': user.dateOfBirth,
          'avatar': user.avatar,
          'bio': user.bio
        },
      ),
    );
  }

  @override
  Future<void> addSocialProviders(Map<SocialMediaType, String> providers) async {
    await _profileRemoteDataSource.addSocialProviders(providers);
  }
}
