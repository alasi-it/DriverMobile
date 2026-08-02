import 'package:google_sign_in/google_sign_in.dart';
import 'package:isnad_worker/core/utils/logger/logger.dart';

class SocialAuthService {
  Future<String?> loginWithGoogle() async {
    try {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '304997238406-1ai0fmgost80v63kek7hb0v8n5lb2g7a.apps.googleusercontent.com',
      );

      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        AppLogger.debug("Google Sign-In not supported");
        return null;
      }

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        AppLogger.debug("Google ID Token is null");
        return null;
      }

      return googleAuth.idToken;
    } catch (e) {
      AppLogger.debug("Google login error: $e");
      return null;
    }
  }
}
