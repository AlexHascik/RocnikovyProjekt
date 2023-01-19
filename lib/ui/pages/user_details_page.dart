import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/apis/fetch_user_details.dart';
import 'package:rocnikovy_projekt/data/registration.dart';
import 'package:rocnikovy_projekt/data/user_details.dart';
import 'package:rocnikovy_projekt/ui/widgets/details_text_widget.dart';
import 'package:rocnikovy_projekt/ui/widgets/text_padding_widget.dart';

class UserDetailsPage extends StatelessWidget{
  final int id;
  late final Future<UserDetails> userDetails;
  final FetchUserDetails fetchUserDetails= FetchUserDetails();
  UserDetailsPage({super.key, required this.id});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Osobné údaj'),
        
      ),
      body: FutureBuilder<UserDetails>(
        future: fetchUserDetails.getUserDetails(id),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            UserDetails userDetails = snapshot.data!;
            return Details(userDetails: userDetails);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator()
             );
          }
        }

      )
    );
  }
}

class Details extends StatelessWidget {
  final UserDetails userDetails;
  const Details({super.key, required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      
          child: ListView(
            children: [Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const DetailsText(head: 'Foto: ', value: ''),
                  ProfilePicture(userDetails: userDetails),
                  const TextWithPadding(text: 'Osobné údaje'),
                  DetailsText(head: 'Titul: ', value: userDetails.title!),                
                  DetailsText(head: 'Meno: ', value: userDetails.firstName!),
                  DetailsText(head: 'Priezvisko: ', value: userDetails.lastName!),
                  DetailsText(head: 'Národnosť: ', value: userDetails.nationality!),
                  DetailsText(head: 'Krajina narodenia: ', value: userDetails.birthdayCountry!),
                  DetailsText(head: 'Pohlavie: ', value: userDetails.gender!),
                  // DetailsText(head: 'Rodné číslo: ', value: userDetails.identificationNumber!),
                  DetailsText(head: 'Dátum narodenia: ', value: userDetails.birthday!),
                  DetailsText(head: 'Členský príspevok ', value: userDetails.feeValid!),
                  const TextWithPadding(text: 'Bydlisko'),
                  DetailsText(head: 'Mesto: ', value: userDetails.region!.name!),
                  DetailsText(head: 'Ulica: ', value: userDetails.street!),
                  DetailsText(head: 'Popisné číslo: ', value: userDetails.streetNumber!),
                  DetailsText(head: 'PSČ: ', value: userDetails.postalCode!),
                  const TextWithPadding(text: 'Ostatné údaje'),
                  DetailsText(head: 'Email: ', value: userDetails.email!),
                  DetailsText(head: 'Telefón: ', value: userDetails.phone!),
                  DetailsText(head: 'IBAN: ', value: userDetails.iban!),
                  const TextWithPadding(text: 'NBC'),
                  DetailsText(head: 'NBC číslo: ', value: userDetails.nbcId!),
                  DetailsText(head: 'NBC funkcionárske číslo: ', value: userDetails.nbcFuncId!),
                  DetailsText(head: 'Dátum lek. prehliadky: ', value: userDetails.healthValid!),
                  DetailsText(head: 'Dátum podpisu antidopingu: ', value: userDetails.antidopingValid!),
                  DetailsText(head: 'Meno doktora: ', value: userDetails.doctorName!),
                  const TextWithPadding(text: 'Registrácie v inštitúcií'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userDetails.registrations!.length,
                      itemBuilder: (context, index) {
                        return _RegistrationInfo(registration: userDetails.registrations![index]);
                      },
                    ),
                  )

                ],
              ),
            ),
          ])
        
    );
  }
}

class ProfilePicture extends StatelessWidget{
  final UserDetails userDetails;
  const ProfilePicture({super.key, required this.userDetails});

  @override 
  Widget build(BuildContext context){
      return Align(
        alignment: Alignment.center,
        child: Visibility(
                        visible: userDetails.photo != '',
                        child: GestureDetector(
                          onTap: (){
                            showDialog(  
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(  
                                  content: Image.network(userDetails.photo!),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: (() => Navigator.of(context).pop()
                                    ),
                                      child: const Icon(Icons.cancel, color: Colors.black)
                                    ),
                                    
                                  ],
                                );
                              }
                            );
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userDetails.photo!)
                          ),
                        )
      
                      ),
        
      );
  }
}

class _RegistrationInfo extends StatelessWidget{
  final Registration registration;
  const _RegistrationInfo({required this.registration});

  @override 
  Widget build(BuildContext context){
    return ExpansionTile(title: 
      Text(registration.institution!.name!,
        style: const TextStyle(  
          fontSize: 15
        )
      ),
      children:[
        
        DetailsText(head: 'Id: ', value: registration.id!),
        DetailsText(head: 'Od: ', value: registration.from!),
        DetailsText(head: 'Do: ', value: registration.to!),
        DetailsText(head: 'Status: ', value: registration.status!),
        DetailsText(head: 'Typ: ', value: registration.type!)

      ]
      );
  }
}

