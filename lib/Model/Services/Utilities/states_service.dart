import 'dart:convert';
import 'package:covid_tracker/Model/Services/Utilities/App_url.dart';
import 'package:covid_tracker/Model/DataModel.dart';
import 'package:http/http.dart' as http;
class statesServices{
  Future<DataModel> fetchRecord() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return DataModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesapi() async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }
}
