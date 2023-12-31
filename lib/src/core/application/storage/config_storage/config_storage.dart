/// Persistent storage for config settings.
abstract interface class IConfigSettingsStorage {
  /// Returns proxy url.
  Future<String?> getProxyUrl();

  /// Save proxy url [proxy].
  Future<void> setProxyUrl({required String proxy});
}
