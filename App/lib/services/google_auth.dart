// ignore_for_file: avoid_print

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthentication{

  Future<void> googleSignIn()async{
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();

    if(googleAccount == null){
      print("NO GOOGLE ACCOUNT DETECTED!!");
      return;
    }
    else{
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
      print('STEP 1');

      if((googleAuth.accessToken != null) && (googleAuth.idToken != null)){
        try{

          print('STEP 2');

          await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken
            )
          );

          print('STEP 3');
        }
        on FirebaseException catch (error){
          print(error.toString());
          return;
        }
        catch(error){
          print(error.toString());
          return;
        }
      }
      else{
        print(googleAuth.accessToken);
        print(googleAuth.idToken);
        return;
      }
    }
  }

  Future<void> googleLogout()async{
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
}