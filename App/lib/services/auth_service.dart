import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  MyUser? userFromFirebaseUser(User? user) {
    return user != null
        ? MyUser(
            profile: user.photoURL,
            email: user.email,
            fullName: user.displayName,
            mobile: user.phoneNumber,
            token: 'NO TOKEN',
            uid: user.uid)
        : null;
  }

  Stream<MyUser?> get user {
    return _authService.authStateChanges().map((userFromFirebaseUser));
  }

  // Future<int> verifyPhone(String phoneNum, BuildContext context)async{
  //   _authService.verifyPhoneNumber(
  //     phoneNumber: phoneNum,
  //     verificationCompleted: (PhoneAuthCredential credential){},

  //     verificationFailed: (FirebaseException e){
  //       if(e.code == 'invalid-phone-number'){
  //         print('INVALID PHONE NUMBER');
  //       }
  //     },

  //     codeSent: (String verificationId, int? resendToken)async{
  //       verificationId
  //     },

  //     codeAutoRetrievalTimeout: (String verificationId){

  //     }
  //   );
  // }

  Future register(String email, String password, String fullName) async {
    try {
      UserCredential result = await _authService.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      await user!.updateDisplayName(fullName);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential result = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future logout() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      print('ERROR LOGGING OUT');
      return null;
    }
  }
}
