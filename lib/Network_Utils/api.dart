import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//a network class that manages all API methods
class Network{

  //the base URL of our laravel api
  final String _url = 'http://oyousef.scweb.ca/lovebirds/api/v1';
  //if you are using android studio emulator, change localhost to 10.0.2.2

  //this will store API token for authentication and attached to every authentication request
  var token;

  //an asynchronous function that checks for a token stored in the user device and assigns it
  //to the initially defined string token
  _getToken() async {
    //getting an instance of the local storage through sharedPreferences
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    //converting the key-value pair to into an array
    token = jsonDecode(localStorage.getString('token') ?? "nothing")['token'];
  }

  //an asynchronous function that handles all post request to our login and register api endpoint
  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;

    //making the post request with parameters involved
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  //an async function that performs GET request
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  //setting the headers
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token',
    'Access-Control': "Access-Control-Allow-Origin"
  };

}