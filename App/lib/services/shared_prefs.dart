import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  Future<void> setIsCustomer(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isCustomer', value);

    print('PREFS SAVED');
  }

  Future<String?> getToken()async{
    return (await SharedPreferences.getInstance()).getString('token');
  }
}