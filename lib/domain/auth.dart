class Auth {
  final String? userId;
  final String? email;

  const Auth({
    required this.userId,
    required this.email
  });

  bool get isAuthenticated => userId != null;
}