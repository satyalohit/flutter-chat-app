import 'package:flutter/material.dart';
import 'package:sixthapp/picker/user_imagepicker.dart';
import 'dart:io';

class Authform extends StatefulWidget {
  Authform(this.submitfn, this.isloading);
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool islogin,
    BuildContext ctx,
  ) submitfn;
  final bool isloading;
  @override
  _AuthformState createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formkey = GlobalKey<FormState>();
  var _islogin = true;
  String username = '';
  String emailaddress = '';
  String password = '';
  File userimagefile=File('');

  void pickedimage(File image) {
    userimagefile = image;
  }

  void _trysubmit() {
    final _isvalid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (userimagefile == File('') &&  !_islogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'please pick an image',
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));

      return;
    }

    if (_isvalid) {
      _formkey.currentState!.save();
      widget.submitfn(
        emailaddress.trim(),
        password.trim(),
        username.trim(),
        userimagefile,
        _islogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_islogin) Userimagepick(pickedimage),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Emailaddress'),
                    onSaved: (value) {
                      emailaddress = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email.';
                      }
                      return null;
                    },
                  ),
                  if (!_islogin)
                    TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (value) {
                          username = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please  enter atleast 4 characters.';
                          }
                          return null;
                        }),
                  TextFormField(
                    key: ValueKey('Password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be greater than 7 letters.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      onPressed: _trysubmit,
                      child: Text(_islogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isloading)
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
