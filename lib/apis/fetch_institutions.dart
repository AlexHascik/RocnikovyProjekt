import 'dart:convert';

import 'package:rocnikovy_projekt/apis/api.dart';
import 'package:rocnikovy_projekt/data/institution.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FetchInstitutions extends API{
    Future<List<Institution>> getInstitutions() async {
    var prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(super.institutionsList),
        headers: <String, String>{
          'X-Registrations-AccessToken': prefs.getString('accessToken')!
          },
    );

      final body = json.decode(response.body);
      return parseInstitutions(body);

  }

   List<Institution> parseInstitutions(dynamic responseBody) {
    if (responseBody is String) {
        final parsed = json.decode(responseBody);
        final institutions = parsed["institutions"] as List;
        return institutions.map((e) => Institution.fromJson(e)).toList();
    }
    final institutions = responseBody["institutions"] as List;
    return institutions.map((e) => Institution.fromJson(e)).toList();
}
}