class UserState {
  final String email;
  final String password;

  UserState({required this.email, required this.password});

  UserState copyWith({String? email, String? password}) {
    return UserState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
