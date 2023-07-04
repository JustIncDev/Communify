import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/api_group.dart';
import 'group_remote_data_source.dart';

final class GroupRemoteDataSourceImpl implements IGroupRemoteDataSource {
  final SupabaseClient _supabaseClient;

  GroupRemoteDataSourceImpl() : _supabaseClient = Supabase.instance.client;

  @override
  Future<void> createGroup(ApiGroup group) async {
    await _supabaseClient.from('groups').insert({
      'name': group.groupName,
      'description': group.description,
      'theme': group.groupTheme,
      'owner_id': group.ownerId
    });
  }
}
