import 'package:hive/hive.dart';

class HiveDataBase {
  var userid;

  final _myBox = Hive.box('mybox');

  void loadData() {
    userid = _myBox.get("userid");
    userid = (userid == Null || userid == null) ? "" : userid;
  }

  void updateDataBase() {
    _myBox.put("userid", userid);
  }
}

HiveDataBase db = HiveDataBase();
