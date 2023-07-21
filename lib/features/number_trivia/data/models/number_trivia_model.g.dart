// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_trivia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberTriviaModel _$NumberTriviaModelFromJson(Map<String, dynamic> json) =>
    NumberTriviaModel(
      number: NumberTriviaModel.intFromJson(json['number']),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$NumberTriviaModelToJson(NumberTriviaModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('number', NumberTriviaModel.intToJson(instance.number));
  writeNotNull('text', instance.text);
  return val;
}
