import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{
  Future<void> setIsCustomer(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isCustomer', value);

    print('PREFS SAVED');
  }

  Future<bool?> getIsCostumer()async{
    return (await SharedPreferences.getInstance()).getBool('isCustomer');
  }

  Future<void> setToken(String tkn)async{
    await (await SharedPreferences.getInstance()).setString('token', tkn);
    print(tkn);
  }

  Future<String?> getToken()async{
    return (await SharedPreferences.getInstance()).getString('token');
  }

  Future<bool?> isRestCreated()async{
    return (await SharedPreferences.getInstance()).getBool('isRestCreated');
  }

  Future<void> setRestCreated(bool value)async{
    await (await SharedPreferences.getInstance()).setBool('isRestCreated', value);
  }

  Future<void> setRestId(String restId)async{
    await (await SharedPreferences.getInstance()).setString('restID', restId);
  }
}