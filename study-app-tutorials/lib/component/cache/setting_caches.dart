import 'package:tutorials/component/sp/shared_preference_helper.dart';
import 'package:tutorials/constant/sp_constant.dart';

class SettingCaches {
  static Future<String> getDownloadDirectory() {
    return SharedPreferenceHelper.get(SpConstant.download_dir_cache_key,
        SpConstant.download_dir_value_default);
  }

  static Future<bool> cacheDownloadDirectory(String value) {
    return SharedPreferenceHelper.set(SpConstant.download_dir_cache_key, value);
  }
}
