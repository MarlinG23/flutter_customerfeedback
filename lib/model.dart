class User {
  final int userId;
  final String name;
  final String email;
  final String customerfeedback;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.customerfeedback,
  });

  const User.empty({
    this.userId = 0,
    this.name = '',
    this.email = '',
    this.customerfeedback = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        customerfeedback: json['customerfeedback'],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "customerfeedback": customerfeedback,
      };
}
