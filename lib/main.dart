import 'src/config/app_config.dart';
import 'src/config/environment/build_types.dart';
import 'src/config/environment/environment.dart';
import 'src/config/urls.dart';
import 'src/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.debug,
    config: AppConfig(
      url: Url.testUrl,
    ),
  );
  run();
}
