class AuthenticatedUser {
  int? id;
  String? email;
  String? role;
  String? token;

  AuthenticatedUser(
      {this.id,
      this.email,
      this.role,
      this.token});

  AuthenticatedUser.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      email = json['email'];
      role = json['role'];
      token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['role'] = role;
    data['token'] = token;
    return data;
  }
}


  // static Map<String, dynamic> toMap(AuthenticatedUser model) => {
  //       'id': model.id,
  //       'city': model.city,
  //       'contact': model.contact,
  //       'email': model.email,
  //       'is_contact': model.isContact ? '1' : '0',
  //       'user_id': model.userId,
  //     };

  // static String serialize(MyUserModel model) =>
  //     json.encode(MyUserModel.toMap(model));

  // static MyUserModel deserialize(String json) => MyUserModel.fromJson(json);

  // @override
  // String toString() {
  //   return 'AuthenticatedUser{id: $id, email: $email, role: $role, token: $token}';
  // }
// }



// class AuthenticatedUser {
//   int? id;
//   String? email;
//   String? role;
//   String? token;

//   AuthenticatedUser({
//     this.id,
//     this.email,
//     this.role,
//     this.token,
//   });

//   factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
//     return AuthenticatedUser(
//       id: json['id'],
//       email: json['email'],
//       role: json['role'],
//       token: json['token'],
//     );
//   }