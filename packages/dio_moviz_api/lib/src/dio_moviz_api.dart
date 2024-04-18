import 'dart:async';

import 'package:dio/dio.dart';
import 'package:moviz_api/moviz_api.dart';
import 'package:rxdart/subjects.dart';

/// {@template dio_moviz_api}
/// A Flutter implementation of the [MovizApi] that uses local storage.
/// {@endtemplate}
class DioMovizApi extends MovizApi {
  /// {@macro dio_moviz_api}
  DioMovizApi({
    required Dio plugin,
  }) : _plugin = plugin {
    _init();
  }

  final Dio _plugin;

  final _movizStreamController = BehaviorSubject<List<Moviz>>.seeded(const []);

  void _init() {
    _plugin.options.headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZ2UiOiIiLCJhcGlrZXkiOiJiOGMxYjYzMC02NGFmLTQwODMtYmQwNS1kNGRiZmEzYTY0OTUiLCJjb21tdW5pdHlfc3VwcG9ydGVkIjpmYWxzZSwiZXhwIjoxNzE2MDU0NjA4LCJnZW5kZXIiOiIiLCJoaXRzX3Blcl9kYXkiOjEwMDAwMDAwMCwiaGl0c19wZXJfbW9udGgiOjEwMDAwMDAwMCwiaWQiOiIyNDYxNzY2IiwiaXNfbW9kIjpmYWxzZSwiaXNfc3lzdGVtX2tleSI6ZmFsc2UsImlzX3RydXN0ZWQiOmZhbHNlLCJwaW4iOm51bGwsInJvbGVzIjpbXSwidGVuYW50IjoidHZkYiIsInV1aWQiOiIifQ.C6-_zllq9Fw9gaWaszZHT-jOrl7dglztIlekYvyc1JjUgnTZz0_qeggdBsmKxHxJ8_C1v7h0RZRjUrwGUVMdwV4BBmKKI_SI5ZdpIR-vJLzAceavo_7eucw1NU2cxB-0gsm9L4S3lyuPSNeEAFtgmMP_4lwLKgnNmxq23ocUGdY1ZSFYSCdnIcWbRALZCPUEZ8XUtvdqi59r61LEeSQRqUZF9NsIYe3xeE_Hl0GoXD3qKDX1vASJr5IxJZ9LIetNrGYkgwJS5LeKpVcoEtd8WCOmyrsD55otqq8Z4e7sjyj4URbXwvlbGtKbTWP51nM08iYF93wOQgicb8U6cC3AjzScJHRY1NEh9q_QzryB21997xIWuNEHVlDJ1u7n68OCrpYrunEfSopfY42oQNiqKXFj0-eliVKO4pJ3DBdvwyvO1t_O8oG7L_z0tr10Z6zpaLMaQjLJQMJ03XYM5faz6SuFeT_FeTk3hB_lpv3m7yWS3XGGH2RPuVfZeVPTtMfp50v3WddiRRHznp__n2iGICxO3JrEM0Cy8TLe99EUyvhHE174TD26JslSspLwA_RGeEFYLv1AgR7JtUY6bVU3fNHlPqn1PF9h33fnFPnv33rIRPbfVXJxia6bWXxbA7k5g-FD7zPpZHQOV-Td8XnjiiiEe6qy_si_UeLTvlHxlzM',
    };
    try {
      _plugin.get('https://api4.thetvdb.com/v4/movies?page=1').then((value) {
        if (value.statusCode == 200) {
          MovieResponse movieResponse = MovieResponse.fromJson(value.data);
          _movizStreamController.add(movieResponse.data);
        } else {
          _movizStreamController.add([]);
        }
      });
    } catch (error) {
      _movizStreamController.add([]);
    }
  }

  @override
  Stream<List<Moviz>> getMoviz() => _movizStreamController.asBroadcastStream();
}
