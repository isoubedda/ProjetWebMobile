import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String createJwt(String subject,String issuer,String pass){
  final jwt = JWT(
    {
      'iat': DateTime.now().microsecondsSinceEpoch,
    },
    subject: subject,
    issuer: issuer,
  );
  return jwt.sign(SecretKey(pass));
  
}

dynamic verifyJwt(String token,String pass){
  try{
      final jwt = JWT.verify(token, SecretKey(pass));
      return jwt;
  } on JWTExpiredError{

  } on JWTError catch(e){

  }
  
  
}