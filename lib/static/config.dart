import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String completionModel = "text-davinci-003";
  static String chatModel = "gpt-3.5-turbo";
  static String baseApiUrl = "https://api.openai.com/v1";
}

class Env {
  static final openAiKey = dotenv.env['OPENAI_API_KEY'];
  static final dropboxToken = dotenv.env['DROPBOX_TOKEN'];
  static final dropboxBaseUrl = dotenv.env['DROPBOX_BASE_URL'];
}
