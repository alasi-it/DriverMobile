class AppConfig {
  static const bool enableMocking = true;

  static const int mockDelayMs = 500;

  static const bool enableDebugLogs = true;

  static const String environment = 'development';

  static const bool enableCaching = true;
  static const bool enableLogging = true;

  static bool get isDevelopment => environment == 'development';

  static bool get isProduction => environment == 'production';

  static bool get shouldEnableMocking => enableMocking && isDevelopment;

  static const String xTenantId = 'd9172f71-8ba2-4d01-b4be-f7e6d0b89e3a';
}
