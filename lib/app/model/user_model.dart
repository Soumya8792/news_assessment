class User {
  String? userId;
  String? email;
  String? fname;
  String? loc;
  String? mob;

  User({this.userId, this.email, this.fname, this.loc, this.mob});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      email: map['email'],
      fname: map['fname'],
      loc: map['loc'],
      mob: map['mob'],
    );
  }
}
