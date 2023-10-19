import 'package:http/http.dart' as http;
import 'dart:io';
class HttpHelper {
  final String _urlKey = "?api_key=5a36356d15d51cb36091bf0cf5c55c3d";
  final String _urlBase = "https://api.themoviedb.org/";

Future<String> getMovie(String type) async{
  var url = Uri.parse(_urlBase + type + _urlKey);
  http.Response result = await http.get(url);
  if (result.statusCode == HttpStatus.ok) {
    String responseBody = result.body;
    return responseBody;
  }
  return result.statusCode.toString();
}
}