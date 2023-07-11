import 'package:json_annotation/json_annotation.dart';

part 'bad_words.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BadWordsResponse {
  final int? badWordsTotal;
  final String? content;
  final String? censoredContent;
  final List<BadWord>? badWordsList;

  BadWordsResponse(
      {required this.badWordsTotal,
      required this.content,
      required this.censoredContent,
      required this.badWordsList});

  factory BadWordsResponse.fromJson(Map<String, dynamic> json) =>
      _$BadWordsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BadWordsResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BadWord {
  final int? deviations;
  final int? end;
  final int? info;
  final String? original;
  final int? replacedLen;
  final int? start;
  final String? word;

  BadWord(
      {required this.deviations,
      required this.end,
      required this.info,
      required this.original,
      required this.replacedLen,
      required this.start,
      required this.word});

  factory BadWord.fromJson(Map<String, dynamic> json) =>
      _$BadWordFromJson(json);
  Map<String, dynamic> toJson() => _$BadWordToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BadWordsRequest {
  final String body;

  BadWordsRequest({required this.body});

  factory BadWordsRequest.fromJson(Map<String, dynamic> json) =>
      _$BadWordsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BadWordsRequestToJson(this);
}
