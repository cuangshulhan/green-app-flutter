import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return email;
    } catch (e) {
      //print(e.toString());
      if (e.message ==
          'The password is invalid or the user does not have a password.') {
        return 'Password yang dimasukan salah';
      } else if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        return 'Email tidak ditemukan';
      } else if (e.message ==
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        return 'Halaman tidak bisa diakses';
      } else if (e.message == 'The email address is badly formatted.') {
        return 'Format email yang dimasukan salah';
      } else if (e.message ==
          'We have blocked all requests from this device due to unusual activity. Try again later.') {
        return 'Akun kamu diblokir untuk sementara waktu,\n coba kembali lain waktu';
      }
    }
  }
}
