import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/job_status.dart';

class SymblApi {
  Future<Response>? _tokenResp;
  DateTime _tokenReqSent = DateTime.now();

  Future<String> getToken() async {
    try {
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

      var expiration = _tokenReqSent.add(Duration(seconds: resp.data['expiresIn']));
      if (DateTime.now().compareTo(expiration) >= 0) {
        _tokenResp = null;
        return getToken();
      }
      return resp.data['accessToken'];
    } catch(e) {
      return getToken();
    }
  }

  Future<JobStatus> getJobStatus(ConversationJob job) async {
    try {
      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Response resp = await Dio().get('https://api.symbl.ai/v1/job/${job.jobId}', options: Options(headers: headers));

      switch(resp.data['status']) {
        case 'scheduled':
          return JobStatus.scheduled;
        case 'in_progress':
          return JobStatus.inProgress;
        case 'completed':
          return JobStatus.completed;
        case 'failed':
          return JobStatus.failed;
        default:
          return JobStatus.failed;
      }
    } catch(e) {
      return JobStatus.failed;
    }
  }

  Future<void> waitForJobCompletion(ConversationJob job) async {
    try {
      var status = await getJobStatus(job);
      while (status != JobStatus.completed && status != JobStatus.failed) {
        await Future.delayed(const Duration(seconds: 1));
        status = await getJobStatus(job);
      }
      return;
    } catch(e) {
      return;
    }
  }

  Future<ConversationJob?> sendText(String name, String message) async {
    try {
      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      var payload = {
        'name': name,
        'detectPhrases': true,
        'detectEntities': true,
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
      return ConversationJob(resp.data['conversationId'], resp.data['jobId']);
    } catch(e) {
      return null;
    }
  }

  Future<ConversationJob?> sendAudio(String name, int speakers, String path) async {
    try {
      var token = await getToken();

      var payload = File(path).readAsBytesSync();
      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Length': payload.length.toString(),
      };

      http.Response resp = await http.post(Uri.parse('https://api.symbl.ai/v1/process/audio?name=$name&detectEntities=true&detectPhrases=true&enableSpeakerDiarization=true&diarizationSpeakerCount=$speakers'), headers: headers, body: payload);
      return ConversationJob(json.decode(resp.body)['conversationId'], json.decode(resp.body)['jobId']);
    } catch(e) {
      return null;
    }
  }

  Future<String?> getName(ConversationJob job) async {
    try {
      await waitForJobCompletion(job);

      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
      };

      Response resp = await Dio().get('https://api.symbl.ai/v1/conversations/${job.conversationId}', options: Options(headers: headers));
      return resp.data['name'];
    } catch(e) {
      return null;
    }
  }

  Future<List<String>?> getTranscript(ConversationJob job) async {
    try {
      await waitForJobCompletion(job);

      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
      };
      var payload = {
        'contentType': 'text/markdown',
        'createParagraphs': true,
        'phrases': {
          'highlightAllKeyPhrases': false,
        },
        'showSpeakerSeparation': true,
      };

      Response resp = await Dio().post('https://api.symbl.ai/v1/conversations/${job.conversationId}/transcript', options: Options(headers: headers), data: payload);
      return resp.data['transcript']['payload'].split('<br><br>');
    } catch(e) {
      return null;
    }
  }

  Future<List<String>?> getTopics(ConversationJob job) async {
    try {
      await waitForJobCompletion(job);

      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
      };
      var parameters = {
        'refresh': true,
      };

      Response resp = await Dio().get('https://api.symbl.ai/v1/conversations/${job.conversationId}/topics', options: Options(headers: headers), queryParameters: parameters);
      return resp.data['topics'].map((topic) => topic['text']).cast<String>().toList();
    } catch(e) {
      return null;
    }
  }

  Future<List<String>?> getActionItems(ConversationJob job) async {
    try {
      await waitForJobCompletion(job);

      var token = await getToken();

      var headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Response resp = await Dio().get('https://api.symbl.ai/v1/conversations/${job.conversationId}/action-items', options: Options(headers: headers));
      return resp.data['actionItems'].map((topic) => topic['text']).cast<String>().toList();
    } catch(e) {
      return null;
    }
  }
}