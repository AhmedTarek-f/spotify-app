import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_auth_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_firebase_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_format_exceptions.dart';
import 'package:spotify/core/utlis/exceptions/t_platform_exceptions.dart';

abstract class RegisterWithEmailAndPasswordService {
  static final _auth = FirebaseAuth.instance;
  // EmailAuthentication - Register
  static Future<UserCredential> registerWithEmailAndPassword(String email,String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e)
    {
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch(e)
    {
      throw TPlatformException(e.code).message;
    }
    catch (e)
    {
      throw "Something went wrong, Please try again";
    }
  }
}