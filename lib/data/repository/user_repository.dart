import 'package:rooforall/data/provider/user_provider.dart';

class UserRepository {
  Future<dynamic> logUser(String anUserName, String aPassword)async =>
     await UserProvider().logUserWithHttp(anUserName, aPassword);
}
