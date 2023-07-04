import 'package:json_annotation/json_annotation.dart';

part 'api_group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiGroup {
  final String groupName;
  final String groupTheme;
  final String? description;
  final String ownerId;

  ApiGroup({
    required this.groupName,
    required this.groupTheme,
    required this.ownerId,
    this.description,
  });

  factory ApiGroup.fromJson(Map<String, dynamic> json) => _$ApiGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ApiGroupToJson(this);
}
