import 'package:rooforall/data/provider/user_provider.dart';

class UserRepository {
  Future<dynamic> logUser(String anUserName, String aPassword) async =>
      await UserProvider().logUser(anUserName, aPassword);

  Future<dynamic> registerUser(
          String aEmail, String anUserName, String aPassword) async =>
      await UserProvider().registerUser(aEmail, anUserName, aPassword);

  Future<dynamic> getUserInformation(String aBearerToken) async =>
      await UserProvider().getUserInformation(aBearerToken);
}
