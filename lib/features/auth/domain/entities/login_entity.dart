class LoginEntity {
  final String? accessToken;
  final String? refreshToken;
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? image;

  LoginEntity({
     this.accessToken,
     this.refreshToken,
     this.id,
     this.username,
     this.email,
     this.firstName,
     this.lastName,
     this.gender,
     this.image,
  });
}
