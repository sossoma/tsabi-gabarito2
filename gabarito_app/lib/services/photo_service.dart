import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotoService {
  PhotoService(String baseUrl, {http.Client? client})
      : _baseUri = Uri.parse(baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'),
        _client = client ?? http.Client();

  final Uri _baseUri;
  final http.Client _client;

  Uri _build(String path) => _baseUri.resolve(path.startsWith('/') ? path.substring(1) : path);

  Future<String> startSession({required String examId, required int photosExpected}) async {
    final Uri url = _build('/api/sessions/start');
    final http.Response res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'examId': examId,
        'photosExpected': photosExpected,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('startSession failed: ${res.statusCode} ${res.body}');
    }
    final Map<String, dynamic> data = jsonDecode(res.body) as Map<String, dynamic>;
    return data['sessionId'] as String;
  }

  Future<({Uri uploadUrl, String objectKey, Map<String, String> headers})> presign({
    required String sessionId,
    String contentType = 'image/jpeg',
  }) async {
    final Uri url = _build('/api/uploads/presign');
    final http.Response res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'sessionId': sessionId,
        'contentType': contentType,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('presign failed: ${res.statusCode} ${res.body}');
    }
    final Map<String, dynamic> data = jsonDecode(res.body) as Map<String, dynamic>;
    final String uploadUrlStr = data['uploadUrl'] as String;
    final String key = data['objectKey'] as String;
    final Map<String, String> hdrs = (data['headers'] as Map?)?.cast<String, String>() ?? <String, String>{'Content-Type': contentType};
    return (uploadUrl: Uri.parse(uploadUrlStr), objectKey: key, headers: hdrs);
  }

  Future<void> uploadBytes({
    required Uri uploadUrl,
    required List<int> bytes,
    Map<String, String> headers = const {'Content-Type': 'image/jpeg'},
  }) async {
    final http.Response res = await _client.put(uploadUrl, headers: headers, body: bytes);
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('upload failed: ${res.statusCode} ${res.body}');
    }
  }

  Future<void> register({
    required String sessionId,
    required String objectKey,
    required int pageNumber,
    String kind = 'page',
  }) async {
    final Uri url = _build('/api/photos/ingest');
    final http.Response res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'sessionId': sessionId,
        'objectKey': objectKey,
        'pageNumber': pageNumber,
        'kind': kind,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('register failed: ${res.statusCode} ${res.body}');
    }
  }

  Future<void> finalize(String sessionId) async {
    final Uri url = _build('/api/sessions/finalize');
    final http.Response res = await _client.post(
      url,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{'sessionId': sessionId}),
    );
    if (res.statusCode != 200) {
      throw Exception('finalize failed: ${res.statusCode} ${res.body}');
    }
  }
}


