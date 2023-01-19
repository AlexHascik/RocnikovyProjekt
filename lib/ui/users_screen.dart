
import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/ui/pages/user_details_page.dart';
import '../data/user.dart';
import 'package:rocnikovy_projekt/apis/fetch_users.dart';

class UsersScreen extends StatefulWidget{
  const UsersScreen({super.key});

  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen>{
  final UsersApi _usersApi = UsersApi();
   List<User> _allUsers = [];
   List<User> _foundUsers= [];

  void _searchFilter(String key){
    List<User> results =[];
    if(key.isEmpty){
      results = _allUsers;
    } else{
      results = _allUsers.where((u) => u.firstName!.toLowerCase().contains(key.toLowerCase()) || u.lastName!.toLowerCase().contains(key.toLowerCase())).toList();
    }
    setState((){
      _foundUsers = results;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Osoby'),
      ),
      body: 
      Column(  
        
        children: [
          Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          onChanged: (value) => _searchFilter(value),
          decoration: const InputDecoration(
          labelText:'Meno alebo Priezvisko',
          suffixIcon: Icon(Icons.search)
        ),
         ),
          ),
           Expanded(
             child: FutureBuilder<List<User>>(
              future: _usersApi.getUsers(),
              builder:(context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(  
                    child: CircularProgressIndicator()
                  );
        
                } else if(snapshot.hasData){
                  final users = snapshot.data!;
                  if(_allUsers.isEmpty){
                   _allUsers= users;
                  _foundUsers =users;
                  }
                  return buildUsers(_foundUsers);
                } else{
                  return const Text('Žiadny hráči sa nenašli');
                }
              }),
           ),
      ])
    );
  }

  Widget buildUsers(List<User> users) => Scrollbar(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                        final user = users[index];
                        return Card(
                            child: ListTile(
                                title: Text("${user.firstName} ${user.lastName}"),
                                subtitle: Text("${user.institutionName}"),
                                trailing: const Icon(Icons.navigate_next),
                                onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserDetailsPage(id: user.id!)),
                                    );
                                },
                            ),
                        );
                    },
                ),
            
        );
}

