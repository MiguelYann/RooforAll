import 'package:rooforall/data/models/user.dart';

class Role {
  final int id;
  final String name;
  final List<User> users;

  Role({this.id, this.users, this.name});
}