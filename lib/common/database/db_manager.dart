
class DbManager {
  //数据库版本号
  static const dbVersion = 1;

//数据库版本名称
  static const dbName = 'todo.db';

//用户信息表
  static const dbTableAccount = 'account';

  static DbManager? _instance;

  DbManager._();

  static DbManager? getDbManager() {
    _instance ??= DbManager._();
    return _instance;
  }

  void init() {
    ///
  }
}
