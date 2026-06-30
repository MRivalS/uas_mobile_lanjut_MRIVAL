class EnvConfig {
  EnvConfig._();

  static const String environment = String.fromEnvironment(
    'ENV_NAME',
    defaultValue: 'DEV',
  );
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'DEV - Mochammad',
  );
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://newsapi.org/v2/',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'YOUR_NEWS_API_KEY_HERE',
  );

  static bool get isProduction => environment == 'PROD';
}
