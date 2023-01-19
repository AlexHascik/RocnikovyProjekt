import 'package:flutter/material.dart';
import 'package:rocnikovy_projekt/apis/fetch_institution_details.dart';
import 'package:rocnikovy_projekt/data/institution_details.dart';
import 'package:rocnikovy_projekt/ui/pages/user_details_page.dart';
import 'package:rocnikovy_projekt/ui/widgets/details_text_widget.dart';
import 'package:rocnikovy_projekt/ui/widgets/text_padding_widget.dart';

class InstitutionDetailsPage extends StatelessWidget{
  final int id;
  late final Future<InstitutionDetails> institutionDetails;
  final FetchInstitutionDetails fetchInstitutionDetails = FetchInstitutionDetails();
  InstitutionDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(  
        title: const Text('Detaily o klube'),
        
      ),
      body: FutureBuilder<InstitutionDetails>(
        future: fetchInstitutionDetails.getInstitutionDetails(id),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            InstitutionDetails institutionDetails = snapshot.data!;
            return Details(institutionDetails: institutionDetails,);
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator()
             );
          }

        },
        
      )
    );
  }

}

  class Details extends StatelessWidget {
  final InstitutionDetails institutionDetails;

  const Details({super.key, required this.institutionDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const TextWithPadding(text: 'Inštitúcia'),
                  DetailsText(head: 'Meno: ', value: institutionDetails.name!),
                  DetailsText(head: 'Športové meno:', value: institutionDetails.sportName!),
                  DetailsText(head: 'IČO: ', value: institutionDetails.ico!),
                  DetailsText(head: 'DIČ: ', value: institutionDetails.dic!),
                  DetailsText(head: 'IČ DPH: ', value: institutionDetails.icdph!),
                  DetailsText(head: 'Právna forma: ', value: institutionDetails.form!),
                  DetailsText(head: 'Email: ', value: institutionDetails.email!),
                  DetailsText(head: 'Web stránka: ', value: institutionDetails.web!),
                  DetailsText(head: 'IBAN pre „sponzorský príspevok: ', value: institutionDetails.ibanState!),
                  DetailsText(head: 'IBAN pre „dotácie zo štátneho rozpočtu“: ', value: institutionDetails.iban!),
                  DetailsText(head: 'Členský poplatok: ', value: institutionDetails.membershipPrice!),
                  DetailsText(head: 'Kľúč delegátov: ', value: institutionDetails.keyDelegate!),
                  DetailsText(head: 'Volené orgány ', value: institutionDetails.voteOrgans!),
                  DetailsText(head: 'Pravidlá uznášania schopnosti: ', value: institutionDetails.voteRules!),
                  DetailsText(head: 'Ulica: ', value: institutionDetails.street!),
                  DetailsText(head: 'Popisné číslo: ', value: institutionDetails.streetNumber!),
                  DetailsText(head: 'PSČ: ', value: institutionDetails.postalCode!),
                  const TextWithPadding(text: 'Členovia inštitúcie'),
                  Padding(  
                    padding:const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: institutionDetails.members!.length ,
                       itemBuilder: (context, index) {
                          final user = institutionDetails.members![index];
                          return Card(
                              child: ListTile(
                                  title: Text("${user.firstName} ${user.lastName}"),
                                  subtitle: Text("${user.institutionName}"),
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
                      )
                  )
               
                ],
              ),
            ),
          ]),
        
    );
  }

}



