import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MakeRequest
{
  final String _url;
  final Map<String, String> _data;

  MakeRequest(this._url, this._data);

  Future<Map> postrequest() async
  {
    Map<String, dynamic> receivedData = {};
    try {
      var response = await http.post(
        Uri.parse(_url),
        body: json.encode(_data),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        receivedData = {
          "status" : response.statusCode,
          "data" : json.decode(response.body.toString())
        };
        
        return receivedData;
      } else {
        receivedData = {
          "status" : response.statusCode,
          "data" : json.decode(response.body.toString())
        };
        return receivedData;
      }
    } catch (e) {
      receivedData = {
        "status" : 0,
        "data" : e.toString()
      };
      return receivedData;
    }
  }

  Future<Map> getrequest() async
  {
    Map receivedData = {};
    try {
      var response = await http.get(
        Uri.parse(_url),
        headers: _data,
      );
      if (response.statusCode == 200) {
        receivedData = {
          "status" : response.statusCode,
          "data" : json.decode(response.body.toString())
        };
        
        return receivedData;
      } else {
        receivedData = {
          "status" : response.statusCode,
          "data" : json.decode(response.body.toString())
        };
        return receivedData;
      }
    } catch (e) {
      receivedData = {
        "status" : 0,
        "data" : e.toString()
      };
      return receivedData;
    }
  }
}