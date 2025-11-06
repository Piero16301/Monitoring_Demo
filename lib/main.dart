import 'package:monitoring_demo/app/app.dart';
import 'package:monitoring_demo/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
