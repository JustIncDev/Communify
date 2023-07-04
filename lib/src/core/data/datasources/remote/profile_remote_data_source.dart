import '../../../application/common/widgets/social_media_list_tile.dart';
import '../../models/api_user.dart';

abstract interface class IProfileRemoteDataSource {
  Future<void> updateUserProfile(ApiUser userProfile);

  Future<void> addSocialProviders(Map<SocialMediaType, String> providers);

  Future<ApiUser> getUserProfile();
}
