import 'dart:io';

import 'package:chat/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthFrom extends StatefulWidget {
  final void Function(String email, String password, String user,XFile image ,bool isLogin,
      BuildContext context) submitFn;
  bool isLogin;

  AuthFrom(this.submitFn, this.isLogin);

  @override
  _AuthFromState createState() => _AuthFromState();
}

class _AuthFromState extends State<AuthFrom> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _user = '';
  String _password = '';
  bool _isLogin = true;
  XFile _UserImageFile=XFile('');

   void _pickedImage(XFile? imagePicker) {
    _UserImageFile = imagePicker!;
  }

  void _submit() {
    final invalid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(_UserImageFile==XFile('')&&!_isLogin){
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('please picked an image'),
        backgroundColor:Colors.red,
      ));
      return;
    }

    if (invalid) {
      _formKey.currentState!.save();
      widget.submitFn(
          _email.trim(), _password.trim(), _user.trim(),_UserImageFile,_isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (!_isLogin)UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect:false,
                  enableSuggestions:false,

                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('com')) {
                      return 'please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect:false,
                    enableSuggestions:false,
                    textCapitalization:TextCapitalization.words,

                    key: const ValueKey('user'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'please enter at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (val) => _user = val!,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'password must be at least 7 characters';
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val!,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                if (widget.isLogin) const CircularProgressIndicator(),
                if (!widget.isLogin)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    onPressed: () {
                      _submit();
                    },
                  ),
                if (!widget.isLogin)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: _isLogin
                        ? const Text('Create new account')
                        : const Text('I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
