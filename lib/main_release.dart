import 'src/core/util/config/app_config.dart';
import 'src/core/util/config/environment/build_types.dart';
import 'src/core/util/config/environment/environment.dart';
import 'src/core/util/config/urls.dart';
import 'src/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(
      url: Url.prodUrl,
    ),
  );
  run();
}
