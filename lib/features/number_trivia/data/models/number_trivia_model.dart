import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/number_trivia.dart';
part 'number_trivia_model.g.dart';

@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    this.number,
    this.text,
  }) : super(number: number, text: text);
  @JsonKey(fromJson: intFromJson, toJson: intToJson)
  @override
  final int? number;
  @override
  final String? text;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

  static int? intFromJson(dynamic value) {
    if (value is num) {
      return value.toInt();
    }
    return null;
  }

  static int? intToJson(num? num) => num?.toInt();
}
