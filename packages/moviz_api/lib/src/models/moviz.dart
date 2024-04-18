import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:moviz_api/moviz_api.dart';

part 'moviz.g.dart';

/// {@template movie_item}
/// A single `movie` item.
///
/// Contains a [name], [image] and [id]
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Movie]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Moviz extends Equatable {
  /// {@macro moviz_item}
  Moviz({
    required this.name,
    required this.id,
  });

  /// The unique identifier of the `moviz`.
  ///
  /// Cannot be empty.
  final int id;

  /// The name of the `moviz`.
  ///
  /// Note that the name will not be empty.
  final String name;

  /// Returns a copy of this `moviz` with the given values updated.
  ///
  /// {@macro moviz_item}
  Moviz copyWith({
    required int id,
    required String name,
  }) {
    return Moviz(
      id: id,
      name: name,
    );
  }

  /// Deserializes the given [JsonMap] into a [Moviz].
  static Moviz fromJson(JsonMap json) => _$MovizFromJson(json);

  /// Converts this [Moviz] into a [JsonMap].
  JsonMap toJson() => _$MovizToJson(this);

  @override
  List<Object> get props => [id, name];
}
