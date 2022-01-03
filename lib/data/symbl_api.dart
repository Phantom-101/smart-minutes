import 'dart:io';
import 'package:dio/dio.dart';
import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/job_status.dart';

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

  Future<JobStatus> getJobStatus(ConversationJob job) async {
    var token = await getToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    Response resp = await Dio().post('https://api.symbl.ai/v1/job/${job.jobId}', options: Options(headers: headers));

    if (resp.statusCode == 200) {
      switch(resp.data['status']) {
        case 'scheduled':
          return JobStatus.scheduled;
        case 'in_progress':
          return JobStatus.inProgress;
        case 'completed':
          return JobStatus.completed;
        case 'failed':
          return JobStatus.failed;
      }
    }
    return JobStatus.failed;
  }

  Future<void> waitForJobCompletion(ConversationJob job) async {
    var status = await getJobStatus(job);
    while (status != JobStatus.completed && status != JobStatus.failed) {
      await Future.delayed(const Duration(seconds: 1));
      status = await getJobStatus(job);
    }
    return;
  }

  Future<ConversationJob?> sendText(String name, String message) async {
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

    if (resp.statusCode == 200) {
      return ConversationJob(resp.data['conversationId'], resp.data['jobId']);
    }
    return null;
  }

  Future<ConversationJob?> sendAudio(String name, String path) async {
    var token = await getToken();

    var payload = File(path).readAsBytesSync();
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Length': payload.length.toString(),
    };
    var parameters = {
      'name': name,
    };

    Response resp = await Dio().post('https://api.symbl.ai/v1/process/audio', options: Options(headers: headers), queryParameters: parameters, data: payload);

    if (resp.statusCode == 200) {
      return ConversationJob(resp.data['conversationId'], resp.data['jobId']);
    }
    return null;
  }

  Future<String?> getName(ConversationJob job) async {
    await waitForJobCompletion(job);

    var token = await getToken();

    var headers = {
      'Authorization': 'Bearer $token',
    };

    Response resp = await Dio().post('https://api.symbl.ai/v1/process/audio', options: Options(headers: headers));

    if (resp.statusCode == 200) {
      return resp.data['name'];
    }
    return null;
  }

  Future<List<String>?> getTranscript(ConversationJob job) async {
    await waitForJobCompletion(job);

    var token = await getToken();

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
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

    if (resp.statusCode == 200) {
      return resp.data['transcript']['payload'].split('<br/><br/>');
    }
    return null;
  }
}