import 'dart:convert';

import 'package:requests/requests.dart';


class NetworkHelper {
  NetworkHelper({required this.url,this.token=""});
  final String url;
  late String token="";
  Future getData() async {
    var res = await Requests.get(url,
     headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+ token,
    }
    );
    if (res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future postData(bodyData)async{
    var res = await Requests.post(url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+token,
    }
    ,body: bodyData,
    bodyEncoding: RequestBodyEncoding.JSON
    );
    if (res.statusCode <300) { 
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to post data');
    }
  }
}
