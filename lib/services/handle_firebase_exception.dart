import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus{ successful, wrongPassword, emailAlreadyExists, invaildEmail, invaildPassword, weakPassword, userNotFound, unknown}
class HandleFirebaseException {
  static handleAuthException(FirebaseAuthException e){
    AuthStatus status = switch (e.code) {
      "Invaild-email" => AuthStatus.invaildEmail,
      "wrong-password" => AuthStatus.invaildPassword,
      "weak-password" => AuthStatus.weakPassword,
      "email-already-in-use" => AuthStatus.emailAlreadyExists,
      "user-not-found" => AuthStatus.userNotFound,
      _ => AuthStatus.unknown
    };
    return status;
  } 
  static String generateErrMsg(error){
    String errMsg = switch (error){
      AuthStatus.invaildEmail => "Your email address is not valid",
      AuthStatus.weakPassword => "Your password should be at least 6 characters",
      AuthStatus.wrongPassword => "Your email or password is wrong",
      AuthStatus.emailAlreadyExists => "The email address is already in use by another accounts",
      AuthStatus.userNotFound => "No user corresponding to the email address",
      _ => "An error occured. Please try again later"
    };
    return errMsg;
  }
  }