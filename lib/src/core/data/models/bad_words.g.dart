// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bad_words.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadWordsResponse _$BadWordsResponseFromJson(Map<String, dynamic> json) =>
    BadWordsResponse(
      badWordsTotal: json['bad_words_total'] as int?,
      content: json['content'] as String?,
      censoredContent: json['censored_content'] as String?,
      badWordsList: (json['bad_words_list'] as List<dynamic>?)
          ?.map((e) => BadWord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BadWordsResponseToJson(BadWordsResponse instance) =>
    <String, dynamic>{
      'bad_words_total': instance.badWordsTotal,
      'content': instance.content,
      'censored_content': instance.censoredContent,
      'bad_words_list': instance.badWordsList,
    };

BadWord _$BadWordFromJson(Map<String, dynamic> json) => BadWord(
      deviations: json['deviations'] as int?,
      end: json['end'] as int?,
      info: json['info'] as int?,
      original: json['original'] as String?,
      replacedLen: json['replaced_len'] as int?,
      start: json['start'] as int?,
      word: json['word'] as String?,
    );

Map<String, dynamic> _$BadWordToJson(BadWord instance) => <String, dynamic>{
      'deviations': instance.deviations,
      'end': instance.end,
      'info': instance.info,
      'original': instance.original,
      'replaced_len': instance.replacedLen,
      'start': instance.start,
      'word': instance.word,
    };

BadWordsRequest _$BadWordsRequestFromJson(Map<String, dynamic> json) =>
    BadWordsRequest(
      body: json['body'] as String,
    );

Map<String, dynamic> _$BadWordsRequestToJson(BadWordsRequest instance) =>
    <String, dynamic>{
      'body': instance.body,
    };
