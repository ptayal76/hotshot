// ignore_for_file: avoid_print

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotshot/model/my_user.dart';
import 'package:hotshot/services/auth_service.dart';

class GoogleAuthentication{

  Future<MyUser?> googleSignIn()async{
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    if(googleAccount == null){
      print("NO GOOGLE ACCOUNT DETECTED!!");
      return null;
    }
    else{
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      print('STEP 1');

      if((googleAuth.accessToken != null) && (googleAuth.idToken != null)){
        try{

          print('STEP 2');

          final result = await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken
            )
          );

          return AuthService().userFromFirebaseUser(result.user);

          print('STEP 3');
        }
        on FirebaseException catch (error){
          print(error.toString());
          return null;
        }
        catch(error){
          print(error.toString());
          return null;
        }
      }
      else{
        print(googleAuth.accessToken);
        print(googleAuth.idToken);
        return null;
      }
    }
  }

  Future<void> googleLogout()async{
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}