import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

Future<QueryExecutor> openExecutor() async {
  final result = await WasmDatabase.open(
    databaseName: 'prompt_optimizer',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.dart.js'),
  );

  return result.resolvedExecutor;
}
