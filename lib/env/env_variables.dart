// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static String API_URL = dotenv.env['API_URL'] ?? 'API_URL_NOT_FOUND';
}
