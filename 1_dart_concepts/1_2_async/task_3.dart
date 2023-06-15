import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void main(List<String> args) async {
  final server = await HttpServer.bind('localhost', 8080);
  print('Server listening on port 8080');

  await for (HttpRequest request in server) {
    if(request.method == 'GET') {
      handleGetRequest(request);
    } else if (request.method == 'POST') {
      handlePostRequest(request);
    } else {
      request.response.statusCode = HttpStatus.methodNotAllowed;
      request.response.write('Method not allowed!');
      request.response.close();
    }
  }
}

void handleGetRequest(HttpRequest request) {
  final file = File('dummy.txt');
  if(file.existsSync()) {
    final content = file.readAsStringSync();
    request.response.write(content);
  } else {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write('Not found!');
  }
  request.response.close();
}

void handlePostRequest(HttpRequest request) async {
  final file = File('dummy.txt');
  final content = await request.transform(utf8.decoder as StreamTransformer<Uint8List, dynamic>).join();
  await file.writeAsString(content);
  request.response.statusCode = HttpStatus.ok;
  request.response.write('File updated');
  request.response.close();
}
