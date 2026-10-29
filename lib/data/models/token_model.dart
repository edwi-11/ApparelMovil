class TokenModel {
final String token;
final int codUsuario;

TokenModel({
  required this.token,
  required this.codUsuario
  });

  static TokenModel fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      codUsuario: json['codUsuario']
      );
  }

  

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'codUsuario': codUsuario
    };
  }



}