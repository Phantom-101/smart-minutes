import 'package:dio/dio.dart';
import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SymblApi {
  Future<Response>? _tokenResp;
  DateTime _tokenReqSent = DateTime.now();

  Future<String> getToken() async {
    if (_tokenResp == null) {
      var headers = {
        'Content-Type': 'application/json',
      };
      var payload = {
        'type': 'application',
        'appId': '6f4d4161656b31667059386f467931525331786e52687176447048474c754535',
        'appSecret': '5259596166504c767855526f4e3876302d3943523559397531785674485342416357326755786c744345694a7757624f7036644439624f355a413576544d6155',
      };

      _tokenReqSent = DateTime.now();
      _tokenResp = Dio().post('https://api.symbl.ai/oauth2/token:generate', options: Options(headers: headers), data: payload);
    }
    var resp = await _tokenResp!;
    if (resp.statusCode == 200) {
      var expiration = _tokenReqSent.add(Duration(seconds: resp.data['expiresIn']));
      if (DateTime.now().compareTo(expiration) > 0) {
        _tokenResp = null;
        return getToken();
      }
      return resp.data['accessToken'];
    } else {
      return getToken();
    }
  }

  Future<ConversationJob?> sendText(String message) async {
    var token = await getToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var payload = {
      'name': 'recording name',
      'enableSummary': true,
      'messages': [
        {
          'payload': {
            'content': message,
          },
        },
      ],
    };

    Response resp = await Dio().post('https://api.symbl.ai/v1/process/text', options: Options(headers: headers), data: payload);
    if (resp.statusCode == 200) {
      return ConversationJob(resp.data['conversationId'], resp.data['jobId']);
    }
    return null;
  }
}