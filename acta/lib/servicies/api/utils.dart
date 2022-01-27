import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const url = 'api.actado.tk';

Future<Response> apiRequest(String method, String path, {Map<String, dynamic>? body}) async {
  String token = await FirebaseAuth.instance.currentUser!.getIdToken();
  switch (method) {
    case 'GET':
      return await http.get(Uri.https(url, path), headers: {'token': token});
    case 'POST':
      return await http.post(Uri.https(url, path), headers: {'token': token}, body: body);
    case 'PATCH':
      return await http.patch(Uri.https(url, path), headers: {'token': token}, body: body);
    case 'DELETE':
      return await http.delete(Uri.https(url, path), headers: {'token': token});
  }
  return Response('', 400);
}
