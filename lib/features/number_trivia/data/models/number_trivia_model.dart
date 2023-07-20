import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/number_trivia.dart';
part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({final int? number, final String? text})
      : super(number: number, text: text);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}
