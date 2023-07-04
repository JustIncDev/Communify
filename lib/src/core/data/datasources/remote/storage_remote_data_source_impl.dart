import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'storage_remote_data_source.dart';

final class StorageRemoteDataSourceImpl implements IStorageRemoteDataSource {
  final SupabaseClient _supabaseClient;

  StorageRemoteDataSourceImpl() : _supabaseClient = Supabase.instance.client;

  @override
  Future<String> uploadFile(File file) async {
    return _supabaseClient.storage.from('CommunifyStorage').upload(
          'public/avatar_${DateTime.now().millisecondsSinceEpoch}.png',
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
  }
}
