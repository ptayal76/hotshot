// ignore_for_file: avoid_print

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthentication {
  Future<MyUser?> googleSignIn() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    if (googleAccount == null) {
      print("NO GOOGLE ACCOUNT DETECTED!!");
      return null;
    } else {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      print('STEP 1');

      if ((googleAuth.accessToken != null) && (googleAuth.idToken != null)) {
        try {
          print('STEP 2');

          final result = await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken));

          print('STEP 3');

          return AuthService().userFromFirebaseUser(result.user);
        } on FirebaseException catch (error) {
          print(error.toString());
          return null;
        } catch (error) {
          print(error.toString());
          return null;
        }
      } else {
        print(googleAuth.accessToken);
        print(googleAuth.idToken);
        return null;
      }
    }
  }

  Future<void> googleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();

    await prefs.remove('token');
    await prefs.remove('isCustomer');
  }
}
