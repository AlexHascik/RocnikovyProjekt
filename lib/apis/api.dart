
class API{

  //routes
   String loginPath = "https://old.kolky.sk/user/login";
   String institutionsList = "https://regapi.kolky.sk/institution/list";
   String institutionDetail = "https://regapi.kolky.sk/institution/detail";
   String registrationsList = "https://regapi.kolky.sk/registration/list";
   String personLookup = "https://regapi.kolky.sk/person/list_v2";
   String personDetail = "https://regapi.kolky.sk/person/detail";
   String validateHash = "https://regapi.kolky.sk/user/validateHash";
   String xAppAccesToken = "SK-81a92pceq-a123-9283-a5f7-0192qwp1mn44";

  //headers 
  Map<String, String> headers = {
    "Content-Type": 'application/json' , //application/json; charset=utf-8
    "X-App-AccessToken": 'SK-81a92pceq-a123-9283-a5f7-0192qwp1mn44'
  };


}    