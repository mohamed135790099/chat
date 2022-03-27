
import 'dart:io';
import 'package:chat/widgets/auth_from.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();

}

bool _isLogin=false;
final _auth = FirebaseAuth.instance;

void _submitAuthForm(String email, String password, String user,XFile img, bool isLogin,
    BuildContext context) async {
  try {

    final UserCredential _resultAuth;
    if (isLogin) {
      _resultAuth = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
    } else {

      _resultAuth = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      try{

        final ref = await firebase_storage.FirebaseStorage.instance.ref('user_image/${_resultAuth.user!.uid+'.jpg'}');
            await ref.putFile(File(img.path));
            final url=await ref.getDownloadURL();
            debugPrint('##########$ref#############');
        await FirebaseFirestore.instance.collection('users').doc(_resultAuth.user!.uid).set({
          'username':user,
          'password':password,
          'image_url':url,
        });

      }catch(e){
        debugPrint('error try again');
      }
    /*  final ref=FirebaseStorage.instance.ref().child('user_image').child(_resultAuth.user!.uid+'jpg');
      await ref.putFile(File(img.path));
      final url=await ref.getDownloadURL();*/
    }
  } on FirebaseAuthException catch (e) {
    String message='error Occurred';
    if (e.code == 'weak-password') {
      message='The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message='The account already exists for that email.';
    } else if (e.code == 'user-not-found') {
      message='No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message='Wrong password provided for that user.';
    }
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor:Theme.of(context).errorColor,));

  }
  catch (e) {
  print(e);

  }

  }



class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .primaryColor
          .withOpacity(0.8),
      body: AuthFrom(_submitAuthForm,_isLogin),
    );
  }
}
