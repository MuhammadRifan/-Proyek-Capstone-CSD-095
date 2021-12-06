class CustomError {
  static String signInResponse(String code) {
    // invalid-email:
    // Thrown if the email address is not valid.
    // user-disabled:
    // Thrown if the user corresponding to the given email has been disabled.
    // user-not-found:
    // Thrown if there is no user corresponding to the given email.
    // wrong-password:
    // Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.

    switch (code) {
      case "invalid-email":
        return "Please input a valid email";
      case "user-disabled":
        return "This user has been banned or disabled";
      case "user-not-found":
        return "User not found or not registered";
      case "wrong-password":
        return "Password is incorrect";
      default:
        return "Oops, something went wrong";
    }
  }

  static String registerResponse(String code) {
    // email-already-in-use:
    // Thrown if there already exists an account with the given email address.
    // invalid-email:
    // Thrown if the email address is not valid.
    // operation-not-allowed:
    // Thrown if email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab.
    // weak-password:
    // Thrown if the password is not strong enough.

    switch (code) {
      case "email-already-in-use":
        return "This account is already exists";
      case "invalid-email":
        return "Please input a valid email";
      case "weak-password":
        return "Password is not strong enough";
      default:
        return "Oops, something went wrong";
    }
  }

  static String signInGoogleResponse(String code) {
    // account-exists-with-different-credential:
    // Thrown if there already exists an account with the email address asserted by the credential. Resolve this by calling [fetchSignInMethodsForEmail] and then asking the user to sign in using one of the returned providers. Once the user is signed in, the original credential can be linked to the user with [linkWithCredential].
    // invalid-credential:
    // Thrown if the credential is malformed or has expired.
    // operation-not-allowed:
    // Thrown if the type of account corresponding to the credential is not enabled. Enable the account type in the Firebase Console, under the Auth tab.
    // user-disabled:
    // Thrown if the user corresponding to the given credential has been disabled.
    // user-not-found:
    // Thrown if signing in with a credential from [EmailAuthProvider.credential] and there is no user corresponding to the given email.
    // wrong-password:
    // Thrown if signing in with a credential from [EmailAuthProvider.credential] and the password is invalid for the given email, or if the account corresponding to the email does not have a password set.
    // invalid-verification-code:
    // Thrown if the credential is a [PhoneAuthProvider.credential] and the verification code of the credential is not valid.
    // invalid-verification-id:
    // Thrown if the credential is a [PhoneAuthProvider.credential] and the verification ID of the credential is not valid.id.

    switch (code) {
      case "user-disabled":
        return "This user has been banned or disabled";
      case "user-not-found":
        return "User not found or not registered";
      case "wrong-password":
        return "Password is incorrect";
      default:
        return "Oops, something went wrong";
    }
  }
}
