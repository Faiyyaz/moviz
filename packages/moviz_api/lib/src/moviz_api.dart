import 'package:moviz_api/moviz_api.dart';

/// {@template moviz_api}
/// The interface for an API that provides access to a list of moviz.
/// {@endtemplate}
abstract class MovizApi {
  /// {@macro moviz_api}
  const MovizApi();

  /// Provides a [Stream] of all moviz.
  Stream<List<Moviz>> getMoviz();
}

/// Error thrown when a [Moviz] with a given id is not found.
class MovizNotFoundException implements Exception {}
