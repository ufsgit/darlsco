import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class NetworkHelper {
  NetworkHelper();

 static Future pay(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile.xml';
    var data = {xml};
    var body = xml.toString();
    // print('body = $body');

    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Response = ${response.statusCode}");
    // print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }

  static Future completed(XmlDocument xml) async {
    String url = 'https://secure.telr.com/gateway/mobile_complete.xml';
    var data = {xml};

    var body = xml.toString();
    // print('body = $body');

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/xml",
      },
    );
    print("Response = ${response.statusCode}");
    print("Response body = ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      return 'failed';
    }
  }
}
