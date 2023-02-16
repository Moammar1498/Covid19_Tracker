import 'package:covid19_tracker/services/states_services.dart';
import 'package:covid19_tracker/view/detailed_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
 class CountriesListScreen extends StatefulWidget {
   const CountriesListScreen({Key? key}) : super(key: key);

   @override
   State<CountriesListScreen> createState() => _CountriesListScreenState();
 }

 class _CountriesListScreenState extends State<CountriesListScreen> {
   TextEditingController searchController = TextEditingController();
   @override
   Widget build(BuildContext context) {
   StatesServices statesServices = StatesServices();
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       ),
       body: SafeArea(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(10),
               child: TextFormField(
                 controller: searchController,
                 onChanged: (value){
                   setState(() {
                   });
                 },
                 decoration: InputDecoration(
                     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                     border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(50)
                     ),
                     hintText: 'Search with the country name'
                 ),
               ),
             ),
             Expanded(
                 child: FutureBuilder(
                   future: statesServices.fetchCountriesList(),
                   builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                     if(!snapshot.hasData){
                       return ListView.builder(
                           itemCount: 6,
                           itemBuilder: (context, index){
                             return Shimmer.fromColors(child: Column(
                               children: [
                                 ListTile(
                                   title: Container(height: 10, width: 89,color: Colors.white,),
                                   subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                   leading: Container(height: 50, width:  50, color: Colors.white,)
                                 )
                               ],),
                                 baseColor: Colors.grey.shade700,
                                 highlightColor: Colors.grey.shade100);
                           });
                     }else{
                       return ListView.builder(
                         itemCount: snapshot.data!.length,
                           itemBuilder: (context, index){
                         String name = snapshot.data![index]['country'];
                         if(searchController.text.isEmpty){
                           return Column(
                             children: [
                               InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailedScreen(
                                     name: snapshot.data![index]['country'],
                                     image: snapshot.data![index]['countryInfo']['flag'],
                                     totalcases: snapshot.data![index]['cases'],
                                     todayrecovered: snapshot.data![index]['todayRecovered'],
                                     totalrecovered: snapshot.data![index]['recovered'],
                                     tests: snapshot.data![index]['tests'],
                                     active: snapshot.data![index]['active'],
                                     critical: snapshot.data![index]['critical'],
                                     totaldeaths: snapshot.data![index]['deaths'],
                                   )));
                           },
                                 child: ListTile(
                                   title: Text(snapshot.data![index]['country']),
                                   subtitle: Text(snapshot.data![index]['cases'].toString()),
                                   leading: Image(height: 50, width: 50,
                                       image: NetworkImage(
                                           snapshot.data![index]['countryInfo']['flag']
                                       )),
                                 ),
                               )
                             ],
                           );
                         }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                           return Column(
                             children: [
                               InkWell(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailedScreen(
                                     name: snapshot.data![index]['country'],
                                     image: snapshot.data![index]['countryInfo']['flag'],
                                     totalcases: snapshot.data![index]['cases'],
                                     todayrecovered: snapshot.data![index]['todayRecovered'],
                                     totalrecovered: snapshot.data![index]['recovered'],
                                     tests: snapshot.data![index]['tests'],
                                     active: snapshot.data![index]['active'],
                                     critical: snapshot.data![index]['critical'],
                                     totaldeaths: snapshot.data![index]['deaths'],
                                   )));
                                 },
                                 child: ListTile(
                                   title: Text(snapshot.data![index]['country']),
                                   subtitle: Text(snapshot.data![index]['cases'].toString()),
                                   leading: Image(height: 50, width: 50,
                                       image: NetworkImage(
                                           snapshot.data![index]['countryInfo']['flag']
                                       )),
                                 ),
                               )
                             ],
                           );
                         }else{
                           return Container();
                         }
                       });
                     }
                   },
                 )
             ),
           ],
         ),
       )

     );
   }
 }
