// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiGroup _$ApiGroupFromJson(Map<String, dynamic> json) => ApiGroup(
      groupName: json['group_name'] as String,
      groupTheme: json['group_theme'] as String,
      ownerId: json['owner_id'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ApiGroupToJson(ApiGroup instance) => <String, dynamic>{
      'group_name': instance.groupName,
      'group_theme': instance.groupTheme,
      'description': instance.description,
      'owner_id': instance.ownerId,
    };
