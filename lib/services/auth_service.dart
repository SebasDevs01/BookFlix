import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import '../models/user_model.dart';

class AuthService {
  FirebaseAuth? _auth;
  GoogleSignIn? _googleSignIn;
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Initialize Firebase services lazily
  FirebaseAuth get auth {
    _auth ??= FirebaseAuth.instance;
    return _auth!;
  }

  GoogleSignIn get googleSignIn {
    _googleSignIn ??= GoogleSignIn(scopes: ['email', 'profile']);
    return _googleSignIn!;
  }

  // Stream de cambios en el estado de autenticación
  Stream<User?> get authStateChanges {
    try {
      return auth.authStateChanges();
    } catch (e) {
      debugPrint('Error getting auth state changes: $e');
      return const Stream.empty();
    }
  }

  // Usuario actual
  User? get currentUser {
    try {
      return auth.currentUser;
    } catch (e) {
      debugPrint('Error getting current user: $e');
      return null;
    }
  }

  // Iniciar sesión con Google
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Activar el flujo de autenticación
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return null;
      }

      // Obtener los detalles de autenticación de la solicitud
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crear una nueva credencial
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Una vez iniciada la sesión, devolver el UserCredential
      final UserCredential userCredential = await auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        return UserModel.fromFirebaseUser(userCredential.user!);
      }

      return null;
    } catch (e) {
      debugPrint('Error en Google Sign In: $e');
      rethrow;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    try {
      await Future.wait([auth.signOut(), googleSignIn.signOut()]);
    } catch (e) {
      debugPrint('Error al cerrar sesión: $e');
      rethrow;
    }
  }

  // Verificar si la autenticación biométrica está disponible
  Future<bool> isBiometricAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      debugPrint('Error verificando biométricos: $e');
      return false;
    }
  }

  // Obtener tipos de biométricos disponibles
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Error obteniendo biométricos disponibles: $e');
      return [];
    }
  }

  // Autenticar con biométricos
  Future<bool> authenticateWithBiometrics() async {
    try {
      final bool isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return false;
      }

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason:
            'Usa tu huella dactilar o Face ID para acceder a BookFlix',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );

      return didAuthenticate;
    } catch (e) {
      debugPrint('Error en autenticación biométrica: $e');
      return false;
    }
  }

  // Verificar si hay sesión iniciada
  bool get isSignedIn => currentUser != null;

  // Obtener información del usuario actual
  UserModel? getCurrentUserModel() {
    final user = currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  // Actualizar perfil del usuario
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final user = currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.updatePhotoURL(photoURL);
        await user.reload();
      }
    } catch (e) {
      debugPrint('Error actualizando perfil: $e');
      rethrow;
    }
  }

  // Eliminar cuenta
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user != null) {
        await user.delete();
        await googleSignIn.signOut();
      }
    } catch (e) {
      debugPrint('Error eliminando cuenta: $e');
      rethrow;
    }
  }

  // Reautenticar con Google (necesario para operaciones sensibles)
  Future<bool> reauthenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user = currentUser;
      if (user != null) {
        await user.reauthenticateWithCredential(credential);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error en reautenticación: $e');
      return false;
    }
  }

  // Obtener token del usuario actual
  Future<String?> getCurrentUserToken() async {
    try {
      final user = currentUser;
      if (user != null) {
        return await user.getIdToken();
      }
      return null;
    } catch (e) {
      debugPrint('Error obteniendo token: $e');
      return null;
    }
  }

  // Verificar si el email está verificado
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  // Enviar email de verificación
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      debugPrint('Error enviando verificación de email: $e');
      rethrow;
    }
  }

  // Recargar información del usuario
  Future<void> reloadUser() async {
    try {
      await auth.currentUser?.reload();
    } catch (e) {
      debugPrint('Error recargando usuario: $e');
      rethrow;
    }
  }
}
