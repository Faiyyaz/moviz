import 'package:moviz_api/moviz_api.dart';

class MovieResponse {
  List<Moviz> data;

  MovieResponse({
    required this.data,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        data: List<Moviz>.from(json["data"].map((x) => Moviz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
