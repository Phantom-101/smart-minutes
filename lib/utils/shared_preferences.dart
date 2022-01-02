import 'package:shared_preferences/shared_preferences.dart';
class StorageUtil {
  var _preferences, initialized;
  StorageUtil(){
    initialized = init();
  }
  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  // get string
  Future<String> getString(String key,{String defValue=""}) async {
    await initialized;
    // print(await _preferences.getString(key) ?? defValue);
    return await _preferences.getString(key) ?? defValue;
  }
  // put string
  Future<dynamic> putString(String key, String value) async{
    await initialized;
    return await _preferences.setString(key, value);
  }

}