import 'dart:convert';
import 'package:assignment_cspar/modules/profile/modals/respoanse.dart';
import 'package:http/http.dart' as httpClient;
import '../../overrides.dart';


class DbService{
  getapi(url) async {
    try {
      
      final response =
          await httpClient.get(Uri.parse(url),);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        if (response.body == 'Unauthorized') {
          ResponseModel _res = await getapi(url);
          return _res;
        }
        return ResponseModel(statusCode: response.statusCode, data: null);
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw ('NO_CONNECTION');
      } else {
        throw (e);
      }
    }
  }

  postapi(api, {body, headers}) async {
    try {
      final response = await httpClient.post(
          Uri.parse('${Overrides.API_BASE_URL}$api'),
          headers: headers ??
              {
                'Content-Type': 'application/json',
              },
          body: json.encode(body));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        if (response.body == 'Unauthorized') {
          ResponseModel _res = await postapi(api, body: body, headers: headers);
          return _res;
        }
        final data = json.decode(response.body);
        return ResponseModel(statusCode: response.statusCode, data: data);
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw ('NO_CONNECTION');
      } else {
        throw (e);
      }
    }
  }

}