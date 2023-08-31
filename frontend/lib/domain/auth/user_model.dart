class User {
  final int? id;
  final String email;
  final String? password;
  final String? role;
  final bool? approved;

  User({
    this.id,
    required this.email,
    this.password,
    required this.role,
    this.approved,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      approved: json['approved'],
    );
  }
}
