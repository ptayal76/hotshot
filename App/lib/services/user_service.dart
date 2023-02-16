import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotshot/model/my_user.dart';

class UserServ {
  Future<void> postUser(MyUser? user) async {
    print('STEP 1 POSt');

    Map m = {
      'name': user?.fullName,
      'email': user?.email,
      'phoneNum': user?.mobile
    };
    Map<String, String> customHeaders = {"content-type": "application/json"};
    final userjson = jsonEncode(m);
    const uri = 'http://10.0.2.2:8000/login';

    var res =
        await http.post(Uri.parse(uri), headers: customHeaders, body: userjson);

    print('POST REQUEST SENT');

    print(res.body);

    print(res.headers['token']);
  }
}
