import 'package:dio_moviz_api/dio_moviz_api.dart';

import 'bootstrap.dart';

void main() {
  final movizApi = DioMovizApi(
    plugin: Dio(),
  );

  bootstrap(movizApi: movizApi);
}
