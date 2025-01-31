import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get filename {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? 'API URL not found!';
  }

  static String get mapsKey {
    return dotenv.env['GMAP_KEY'] ?? 'GMAP KEY not found!';
  }
}
