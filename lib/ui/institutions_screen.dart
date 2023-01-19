import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/apis/fetch_institutions.dart';
import 'package:rocnikovy_projekt/data/institution.dart';
import 'package:rocnikovy_projekt/ui/pages/institution_details_page.dart';


class InstitutionsScreen extends StatefulWidget{
  const InstitutionsScreen({super.key});


  @override
  InstitutionsScreenState createState() => InstitutionsScreenState();
}

class InstitutionsScreenState extends State<InstitutionsScreen>{
  final FetchInstitutions _fetchInstitutions = FetchInstitutions();
  List<Institution> _allInstitutions = [];
   List<Institution> _foundInstitutions= [];

 void _searchFilter(String key){
    List<Institution> results =[];
    if(key.isEmpty){
      results = _allInstitutions;
    } else{
      results = _allInstitutions.where((u) => u.name!.toLowerCase().contains(key.toLowerCase()) || u.sportName!.toLowerCase().contains(key.toLowerCase())).toList();
    }
    setState((){
      _foundInstitutions = results;
    });
  }
   @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Inštitúcie'),
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
             child: FutureBuilder<List<Institution>>(
              future: _fetchInstitutions.getInstitutions(),
              builder:(context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return  const Center(
                    child: CircularProgressIndicator()
                    );
                } else if(snapshot.hasData){
                  final institutions = snapshot.data!;
                  if(_allInstitutions.isEmpty){
                   _allInstitutions= institutions;
                  _foundInstitutions =institutions;
                  }
                  return buildUsers(_foundInstitutions);
                } else{
                  return const Text('Žiadny hráči sa nenašli');
                }
              }),
           ),
      ])
    );
  }
}
 Widget buildUsers(List<Institution> institutions) => Scrollbar(
   child: ListView.builder(  
      itemCount: institutions.length,
      itemBuilder: (context, index){
        final institution = institutions[index];
        return GestureDetector(
          child: Card(
              child: ListTile(  
                title: Text("${institution.name}"),
                subtitle: Text("${institution.sportName}"),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InstitutionDetailsPage(id: institution.id!)));
                  }
              )
          ),
        );
      },
    ),
 );