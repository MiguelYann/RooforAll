class User {
  final int id;
  final String username;
  final String email;
  final String password;
  final bool active;
  final User supervisor;
  
  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.active,
      this.supervisor});
}
