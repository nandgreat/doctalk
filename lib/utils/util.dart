// import 'package:doc_talk/utils/commons.dart';

// import 'constants.dart';

Future<Map> getHeader() async {
  // final _data = await preferencesHelper.getData(key: Commons.usersPrefKey);
  Map<String, dynamic> _map = Map<String, dynamic>();
  _map['Accept'] = 'application/json';
  return _map;
}
