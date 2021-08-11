import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/Auth/Auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authscreen extends StatefulWidget {
  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final _auth = FirebaseAuth.instance;
  var _isloading = false;
  void _submitauthform(
    String email,
    String password,
    String username,
    File image,
    bool islogin,
    BuildContext ctx,
  ) async {
    AuthResult authresult;
    try {
      setState(() {
        _isloading = true;
      });
      if (islogin) {
        final authresult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        final authresult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authresult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();

        await Firestore.instance
            .collection('users')
            .document(authresult.user.uid)
            .setData({
          'username': username,
          'email': email,
          'image_url':url,
        });
      }
    } on PlatformException catch (err) {
      var message = "An error occured,please check your credentials";

      if (err.message != null) {
        message = err.message!;
      }

      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isloading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Authform(_submitauthform, _isloading),
    );
  }
}
