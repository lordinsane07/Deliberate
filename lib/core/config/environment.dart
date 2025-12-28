enum Environment {
  dev,
  prod,
}

class AppEnvironment {
  static const Environment current = Environment.dev;

  static bool get isDev => current == Environment.dev;
  static bool get isProd => current == Environment.prod;
}
