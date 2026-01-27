import 'package:firebase_auth/firebase_auth.dart';

class AuthException implements Exception {
  final String message;
  final String code;
  AuthException(this.message, [this.code = 'unknown']);
  
  @override
  String toString() => message;
}

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth}) 
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Sign Up
  Future<void> kayitOl(String email, String password) async {
    try {
      // 1. Create user
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      // 2. Send verification email immediately
      await _firebaseAuth.currentUser?.sendEmailVerification();

      // 3. Sign out to prevents access before verification
      await _firebaseAuth.signOut();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException('Bu e-posta adresi zaten kullanımda. Giriş yapmayı deneyin.', e.code);
      } else if (e.code == 'weak-password') {
        throw AuthException('Şifre çok zayıf. Daha güçlü bir şifre seçin.', e.code);
      } else if (e.code == 'invalid-email') {
        throw AuthException('Geçersiz e-posta formatı.', e.code);
      } else {
        throw AuthException('Bir hata oluştu: ${e.message}', e.code);
      }
    }
  }

  // Sign In
  Future<void> girisYap(String email, String password) async {
    try {
      // 1. Attempt sign in
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user = userCredential.user;

      // 2. Check if email is verified
      if (user != null && !user.emailVerified) {
        await _firebaseAuth.signOut();
        throw AuthException('Lütfen önce e-posta adresinize gelen doğrulama linkine tıklayınız.', 'email-not-verified');
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        throw AuthException('Böyle bir kullanıcı bulunamadı veya şifre yanlış.', e.code);
      } else if (e.code == 'wrong-password') {
        throw AuthException('Şifre hatalı.', e.code);
      } else if (e.code == 'user-disabled') {
        throw AuthException('Bu kullanıcı hesabı engellenmiş.', e.code);
      } else {
        throw AuthException('Giriş başarısız: ${e.message}', e.code);
      }
    } catch (e) {
      if (e is AuthException) rethrow; // Pass through our custom exceptions
      throw AuthException(e.toString());
    }
  }

  Future<void> cikisYap() async {
    await _firebaseAuth.signOut();
  }

  Future<void> dogrulamaMailiGonder() async {
    User? user = _firebaseAuth.currentUser;

    if (user == null) {
      throw AuthException('Oturum açık değil. Lütfen tekrar giriş yapın.', 'no-user');
    }

    // Refresh user data to get latest emailVerified status
    await user.reload();
    user = _firebaseAuth.currentUser; 

    if (user!.emailVerified) {
      throw AuthException('E-posta adresiniz zaten doğrulanmış!', 'already-verified');
    }

    try {
      await user.sendEmailVerification();
    } catch (e) {
      throw AuthException('Lütfen biraz bekleyip tekrar deneyin.', 'send-failed');
    }
  }

  bool mailOnayliMi() {
    User? user = _firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  Future<void> kullaniciyiYenile() async {
    await _firebaseAuth.currentUser?.reload();
  }

  Future<void> tekrarDogrulamaGonder(String email, String password) async {
    try {
      // 1. Mail atabilmek için geçici giriş yap
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        // 2. Maili gönder
        await user.sendEmailVerification();
        // 3. İşlem bitince tekrar çıkış yap (Güvenlik)
        await _firebaseAuth.signOut();
      } else {
        // Zaten doğrulanmışsa veya kullanıcı yoksa
        await _firebaseAuth.signOut();
        throw 'Hesap zaten doğrulanmış veya bir sorun var.';
      }
    } catch (e) {
      // Olası hataları yakala ve fırlat
      throw 'Mail gönderilemedi. Lütfen biraz bekleyin.';
    }
  }
}