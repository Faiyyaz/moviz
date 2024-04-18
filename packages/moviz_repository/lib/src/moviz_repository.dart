import 'package:moviz_api/moviz_api.dart';

/// {@template moviz_repository}
/// A repository that handles `moviz` related requests.
/// {@endtemplate}
class MovizRepository {
  /// {@macro moviz_repository}
  const MovizRepository({
    required MovizApi movizApi,
  }) : _movizApi = movizApi;

  final MovizApi _movizApi;

  /// Provides a [Stream] of all moviz.
  Stream<List<Moviz>> getMoviz() => _movizApi.getMoviz();
}
