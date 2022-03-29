import '../../moor_db.dart';
import '../tables/tables.dart';

part 'login_user_info_dao.g.dart';

@DriftAccessor(tables: [LoginUserInfos])
class LoginUserInfoDao extends DatabaseAccessor<Database>
    with _$LoginUserInfoDaoMixin {
  LoginUserInfoDao(final Database attachedDatabase) : super(attachedDatabase);

  ///获取所有登录的用户
  Future<List<LoginUserInfo>> getAllUsers() => select(loginUserInfos).get();

  ///根据登录类型和userId获取登录数据
  Future<LoginUserInfo?> getUserByUserId(
    final String userId,
  ) async =>
      (select(loginUserInfos)..where((final tbl) => tbl.userId.equals(userId)))
          .getSingleOrNull();

  ///插入一条登录数据
  Future<void> insertUser(final LoginUserInfo userInfo) async =>
      into(loginUserInfos).insertOnConflictUpdate(userInfo);

  ///更新登录数据
  Future<void> updateLoginUserInfo(final LoginUserInfo userInfo) async =>
      update(loginUserInfos).replace(userInfo);

  ///删除数据
  Future<void> deleteUser(final LoginUserInfo userInfo) async =>
      delete(loginUserInfos).delete(userInfo);

  ///通过userId删除数据
  Future<void> deleteUserByUserId(
    final String userId,
  ) async {
    await (delete(loginUserInfos)
          ..where((final tbl) => tbl.userId.equals(userId)))
        .go();
  }
}
