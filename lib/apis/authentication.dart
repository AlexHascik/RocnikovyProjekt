import 'package:rocnikovy_projekt/apis/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthAPI extends API{

  
  Future<http.Response> login(String email, String password) async {
    var body = jsonEncode(<String, String>{
      'email': email,
      'password': password
    });
    var response = await http.post(Uri.parse(super.loginPath), headers: super.headers, body: body);

    //treba este nejak skoncit ak dostanes v body error code
    if(jsonDecode(response.body)['errorCode'] != null){
      return response;
    }


    if(response.statusCode == 200){

      var accessToken = (jsonDecode(response.body))['accessToken'];
      var bodyToken = jsonEncode({"email": email, "token":accessToken});
      final prefs = await SharedPreferences.getInstance();
      var token = await http.post(Uri.parse(super.validateHash), headers: super.headers, body: bodyToken);
      var tokenBody = jsonDecode(token.body);
      //ulozenie tokenu
      accessToken = tokenBody['user']['accessToken'];
      int id = tokenBody['user']['id'];
      await prefs.setString('accessToken',accessToken);
      await prefs.setInt('id', id);
      return token;
    } else{
      throw Exception('Failed to login');
    }
   
  }
}