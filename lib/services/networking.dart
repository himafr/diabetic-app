import 'dart:convert';

import 'package:requests/requests.dart';


class NetworkHelper {
  NetworkHelper({required this.url});
  final String url;
  Future getData() async {
    var res = await Requests.get(url);
    if (res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future postData(bodyData)async{
    print("here");
    var res = await Requests.post(url,
    headers: {
      'Content-Type': 'application/json',
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
