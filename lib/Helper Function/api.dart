import 'package:dio/dio.dart';

Future<String> getResponse(
    String userMessage, List<String> lastMessages) async {
  String url = "https://groq-api.onrender.com/getReply";
  Dio dio = Dio();
  var response = await dio.post(url,
      data: {'user_message': userMessage, 'last_messages': lastMessages});
  return response.data['response'];
}
