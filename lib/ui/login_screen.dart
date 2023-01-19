import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/apis/authentication.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  //final _formKey = GlobalKey<FormState>(); 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _loginFailed = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
    var _isObscured;   

   @override
    void initState(){
        super.initState();
        _isObscured = true;
    }


  @override 
  Widget build(BuildContext context){
    AuthAPI authAPI = AuthAPI();
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Prihlásenie')
        ),
        body: Column(  
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            Form(
              child: Column(  
                children: [ 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,  
                      decoration: const InputDecoration(  
                        labelText: 'Email',
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(  
                      obscureText: _isObscured,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:  InputDecoration(  
                        labelText: 'Heslo',
                        hintText: 'Heslo',
                        prefixIcon: const Icon(Icons.password),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(  
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          icon: _isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        errorText: _loginFailed? 'Zlý email alebo heslo' : null,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed:() async {
                      
                        var req = await authAPI.login(emailController.text, passwordController.text);
                        if(req.statusCode == 200){
                          var decoded = jsonDecode(req.body);
                          if(decoded['errorCode'] != null){
                            setState(() {
                               _loginFailed= true;
                            });
                          } else{
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) =>  const MainScreen()));
                          }
                          
                        }     
                      },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Login'),
                    ),
                    
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// child: FutureBuilder<List<User>>(
//               future: _usersApi.getUsers(),
//               builder:(context, snapshot){
//                 if(snapshot.connectionState == ConnectionState.waiting){
//                   return const Center(  
//                     child: CircularProgressIndicator()
//                   );
        
//                 } else if(snapshot.hasData){
//                   final users = snapshot.data!;
//                   if(_allUsers.isEmpty){
//                    _allUsers= users;
//                   _foundUsers =users;
//                   }
//                   return buildUsers(_foundUsers);
//                 } else{
//                   return const Text('Žiadny hráči sa nenašli');
//                 }
//               }),


