import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotshot/model/my_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServ {
  Future<String> postUser(MyUser? user) async {
    print('STEP 1 POSt');

    Map m = {
      'name': user?.fullName,
      'email': user?.email,
      'phoneNum': '1234567890'
    };
    Map<String, String> customHeaders = {"content-type": "application/json"};
    final userjson = jsonEncode(m);
    const uri = 'http://192.168.1.106:8080/login';

    var res =
        await http.post(Uri.parse(uri), headers: customHeaders, body: userjson);

    print('POST REQUEST SENT');

    print(res.body);

    final tkn = res.headers['token'];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('token', tkn!);

    print('TOKEN = $tkn');

    return tkn;
  }
}
