import 'package:get/get.dart';

/// Exception class for handling various platform-related errors.
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.'.tr;
      case 'too-many-requests':
        return 'Too many requests. Please try again later.'.tr;
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.'.tr;
      case 'invalid-password':
        return 'Incorrect password. Please try again.'.tr;
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.'.tr;
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.'.tr;
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.'.tr;
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.'.tr;
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.'.tr;
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.'.tr;
      case 'internal-error':
        return 'Internal error. Please try again later.'.tr;
      case 'invalid-verification-code':
        return 'Invalid verification code. Please enter a valid code.'.tr;
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verification code.'.tr;
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.'.tr;
    // Add more cases as needed...
      default:
        return 'An unexpected platform error occurred. Please try again.'.tr;
    }
  }
}
