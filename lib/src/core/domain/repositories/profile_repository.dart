import '../../application/common/widgets/social_media_list_tile.dart';
import '../entities/user.dart';

abstract interface class IProfileRepository {
  Future<void> updateUserProfile(UserDomain user);

  Future<UserDomain> getUserProfile();

  Future<void> addSocialProviders(Map<SocialMediaType, String> providers);
}
