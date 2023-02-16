import 'dart:convert';
import 'package:covid19_tracker/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../models/WorldStatesModel.dart';

class StatesServices{
  Future<WorldStatesModel> fetchWorldStates() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body);
        if(response.statusCode==200){
          return WorldStatesModel.fromJson(data);
        }else{
         throw Exception('Error');
        }
  }
  
  Future<List<dynamic>> fetchCountriesList() async{
    final response = await http.get(Uri.parse(AppUrl.countrieslist));

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      return throw Exception('Error');
    }
  }
}