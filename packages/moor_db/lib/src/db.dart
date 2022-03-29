import 'dao/dao.dart';
import 'db/db.dart';

final db = Database();
final loginUserInfoDao = LoginUserInfoDao(db);
