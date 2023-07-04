import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../application/common/widgets/social_media_list_tile.dart';
import '../../models/api_user.dart';
import 'profile_remote_data_source.dart';

final class ProfileRemoteDataSourceImpl implements IProfileRemoteDataSource {
  final SupabaseClient _supabaseClient;

  ProfileRemoteDataSourceImpl() : _supabaseClient = Supabase.instance.client;

  @override
  Future<void> updateUserProfile(ApiUser userProfile) async {
    final updateData = Map<String, Object?>.fromEntries(
      [
        if (userProfile.firstName != null) MapEntry('first_name', userProfile.firstName),
        if (userProfile.lastName != null) MapEntry('last_name', userProfile.lastName),
        if (userProfile.dateOfBirth != null)
          MapEntry('date_of_birth', userProfile.dateOfBirth?.toIso8601String()),
        if (userProfile.username != null) MapEntry('username', userProfile.username),
        if (userProfile.avatar != null) MapEntry('avatar', userProfile.avatar),
        if (userProfile.bio != null) MapEntry('bio', userProfile.bio),
      ],
    );

    if (updateData.isNotEmpty) {
      await _supabaseClient.from('users').update(updateData).eq('id', userProfile.id);
    } else {
      return Future.error('No fields to update');
    }
  }

  @override
  Future<void> addSocialProviders(Map<SocialMediaType, String> providers) async {
    if (providers.isNotEmpty) {
      final rows = <Map<String, Object>>[];
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId != null) {
        for (final entry in providers.entries) {
          final provider = entry.key.toString().split('.').last;
          final link = entry.value;
          rows.add({
            'provider': provider,
            'provider_id': link,
            'token': '',
            'user_id': userId,
          });
        }
        await _supabaseClient.from('social_accounts').insert(rows);
      }
    }
  }
}
