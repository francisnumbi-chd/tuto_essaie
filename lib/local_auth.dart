import 'package:local_auth/local_auth.dart';

class LocalAuth {
  LocalAuth._();

  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> get _canAuthenticateBiom async {
    if (!await _auth.canCheckBiometrics) return false;
    List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    print(availableBiometrics);
    if (availableBiometrics.isEmpty) return false;

    /*   if (availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.fingerprint)) {
      return true;
    }*/

    if (availableBiometrics.contains(BiometricType.face) ||
        availableBiometrics.contains(BiometricType.fingerprint) ||
        availableBiometrics.contains(BiometricType.iris)) {
      return true;
    }

    return false;
  }

  static Future<bool> _canAuthenticate() async =>
      await _canAuthenticateBiom || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          sensitiveTransaction: true,
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
