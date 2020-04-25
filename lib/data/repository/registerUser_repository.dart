import 'package:rooforall/data/provider/registerUser_provider.dart';

class RegisterUserRepository {
  Future<dynamic> registerUser(
          String aEmail, String anUserName, String aPassword) async =>
      await RegisterUserProvider()
          .registerUserWithDio(aEmail, anUserName, aPassword);
}
