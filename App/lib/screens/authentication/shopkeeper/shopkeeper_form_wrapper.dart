import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hotshot/Signin.dart';
import 'package:hotshot/constants/constants.dart';
import 'package:hotshot/constants/loading.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/screens/authentication/shopkeeper/shopkeeper_sign_in.dart';
import 'package:hotshot/screens/shopkeeper_main_page.dart';
import 'package:hotshot/screens/shopkeeper_verification_form.dart';
import 'package:hotshot/screens/shopkeeperhome.dart';
import 'package:hotshot/services/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ShopkeeperFormWrapper extends StatefulWidget {
  const ShopkeeperFormWrapper({super.key});

  @override
  State<ShopkeeperFormWrapper> createState() => _ShopkeeperFormWrapperState();
}

class _ShopkeeperFormWrapperState extends State<ShopkeeperFormWrapper> {

  bool? isRestCreated;
  String? tkn;

  void setIsRestCreated()async{
    bool? b = await SharedPrefs().isRestCreated();

    setState(() {
      isRestCreated = b;
    });
  }

  void fetchToken()async{
    String? t = await SharedPrefs().getToken();

    print('fetching token');
    print(t);

    setState(() {
      tkn = t;
    });

    print('KSJFGSKLJGSLKJGSL');
  }

  void postEmail(String email)async{
    try{
    String uri = '$MONGO_URL/food/rest/login';



    final body = jsonEncode({
        'email': email
      });

      //Map<String, String> customHeaders = {'Accept':'application/json'};
      final res = await http.post(
        Uri.parse(uri),
        body: body, 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });

      String? t = res.headers['token'];
      SharedPrefs().setToken(t!);
    }
    catch(e)
    {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    setIsRestCreated();
    fetchToken();

    print(isRestCreated);

    if(isRestCreated == true){
      if(tkn == null){
        String? email = Provider.of<MyUser?>(context)!.email;
        postEmail(email!);
        return const Loading();
      }
      else{
        return const MainPage();
      }
    }
    else{
      return ShopkeeperVerificationForm();
    }
  }
}