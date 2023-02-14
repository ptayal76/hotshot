import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';

var provider = OAuthProvider("microsoft.com");
// String s = provider.providerId;
// provider.
var z = provider.credential();
var w = z.idToken;
var x = z.accessToken;
var s = z.providerId;
var q = z.signInMethod;
OAuthCredential userCredential =
    OAuthCredential(providerId: s, signInMethod: q);
  // Future<void> microsoftSignIn()async{

// await FirebaseAuth.instance.signInWithCredential()