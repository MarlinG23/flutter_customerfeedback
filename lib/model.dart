class User {
  final int userId;
  final String name;
  final String email;
  final String role;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
  });

  const User.empty({
    this.userId = 0,
    this.name = '',
    this.email = '',
    this.role = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "role": role,
      };
}
