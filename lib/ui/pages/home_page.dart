import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/ui/institutions_screen.dart';
import 'package:rocnikovy_projekt/ui/users_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: const Text("E-Služby SKoZ"),
      centerTitle: true,
    ),
      body: ListView(
        children:  <Widget>[
          ListTile(title: const Text('Hráči'), 
            subtitle: const Text('Zoznam hráčov'), 
            trailing: const Icon(Icons.navigate_next),
            shape: const Border(bottom: BorderSide()),
            onTap: (){
               Navigator.push(context, MaterialPageRoute(builder:(context) =>   const UsersScreen()));
            }
          ),
          ListTile(title: const Text('Kluby'),
           subtitle: const Text('Zoznam klubov'), 
           trailing:const Icon(Icons.navigate_next),
           shape: const Border(bottom: BorderSide()),
           onTap: (){
               Navigator.push(context, MaterialPageRoute(builder:(context) =>   const InstitutionsScreen()));
            }

          ),
          // ListTile(title:Text('Registrácie'), 
          //   subtitle: Text('Zoznam registrácií'),
          //   trailing: Icon(Icons.navigate_next),
          //   shape: Border(bottom: BorderSide())
          // ),
        ],
        
      )

    );

  }
}