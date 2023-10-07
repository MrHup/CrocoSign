import 'dart:convert';
import 'package:crocosign/static/input_agreement.dart';
import 'package:crocosign/static/config.dart';
import 'package:http/http.dart' as http;

Future<List<String>> generatePdfContent(InputAgreement agreement) async {
  String prompt = "You are a lawyer. ${agreement.generatePrompt()}";
  print(prompt);

  final response = await http.post(
    Uri.parse("${Config.baseApiUrl}/completions"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Env.openAiKey}',
    },
    body: jsonEncode(<String, dynamic>{
      "prompt": prompt,
      "model": Config.completionModel,
      "max_tokens": 1500,
      "temperature": 1.2,
      "presence_penalty": 0.65,
      "frequency_penalty": 0.35,
    }),
  );

  print(response.body);
  print(response.statusCode);

  return [];
}


// Future<List<String>> fetchQuizzes() async {
//   final response = await http.post(
//     Uri.parse("https://api.openai.com/v1/chat/completions"),
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer ${Env.openAiKey}',
//     },
//     body: jsonEncode(<String, dynamic>{
//       "messages": [
//         {
//           "role": "system",
//           "content":
//               "This is a conversation about specific python high level tricks. The conversation is very specific and high level, only experts should be able to follow"
//         },
//         {"role": "assistant", "content": "Hello, how can I help you?"},
//         {
//           "role": "user",
//           "content":
//               "Give me a list of tips, tricks and unknown libraries that I should look into to make my life easier as a python developer. Just list the topics."
//         }
//       ],
//       "model": "gpt-3.5-turbo", // "gpt-3.5-turbo-0301",
//       // "model": "text-davinci-003",
//       "max_tokens": 3000,
//       "temperature": 1.2,
//       //   "top_p": 1,
//       //   "n": 1,
//       "presence_penalty": 0.65,
//       "frequency_penalty": 0.35,
//       //   "stop": ["\n"]
//     }),
//   );

//   print(response.body);
//   print(response.statusCode);
//   return [];
// }

