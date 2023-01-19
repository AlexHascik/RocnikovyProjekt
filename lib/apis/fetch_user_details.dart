import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rocnikovy_projekt/data/user_details.dart';
import 'api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchUserDetails extends API{

  Future<UserDetails> getUserDetails(int id) async {
    var prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(super.personDetail),
        headers: <String, String>{
          'X-Registrations-AccessToken': prefs.getString('accessToken')!,
          'Content-Type': 'application/json'

          },
          body: jsonEncode(<String, int>{
            
            "id": id
          }
    ));
      final body = json.decode(response.body);
      return UserDetails.fromJson(body['person']);
  }
}