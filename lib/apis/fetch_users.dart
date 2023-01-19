import 'dart:convert';

import 'package:rocnikovy_projekt/data/user.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersApi extends API{

  Future<List<User>> getUsers() async {
    var prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(super.personLookup),
        headers: <String, String>{
          'X-Registrations-AccessToken': prefs.getString('accessToken')!
          },
          body: jsonEncode(<String, String>{
            "birthdayFrom": "1890-01-01",
            "birthdayTo": "2030-01-01"
          }
    ));

      final body = json.decode(response.body);
      return parseUsers(body);

  }

 List<User> parseUsers(dynamic responseBody) {
    if (responseBody is String) {
        final parsed = json.decode(responseBody);
        final users = parsed["persons"] as List;
        return users.map((e) => User.fromJson(e)).toList();
    }
    final users = responseBody["persons"] as List;
    return users.map((e) => User.fromJson(e)).toList();
}

}