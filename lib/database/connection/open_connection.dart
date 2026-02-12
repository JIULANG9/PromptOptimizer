import 'package:drift/drift.dart';

import 'open_connection_native.dart'
    if (dart.library.html) 'open_connection_web.dart' as impl;

Future<QueryExecutor> openExecutor() {
  return impl.openExecutor();
}
