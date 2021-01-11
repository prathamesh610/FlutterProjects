import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _passwordVisible = false;
  String _userEmail = '';
  String _userPass = '';
  String _userName = '';
  var height;

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  void _switchAuthMode() {
    if (_isLogin) {
      setState(() {
        _isLogin = !_isLogin;
      });
      _controller.forward();
    } else {
      setState(() {
        _isLogin = !_isLogin;
      });
      _controller.reverse();
    }
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    // closes soft keyboard if it is open
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPass,
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: _isLogin ? 280 : 340,
        duration: Duration(milliseconds: 350),
        curve: Curves.fastOutSlowIn,
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid Email address.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        constraints: BoxConstraints(
                            minHeight: _isLogin ? 0 : 60,
                            maxHeight: _isLogin ? 0 : 120),
                        curve: Curves.easeIn,
                        child: FadeTransition(
                          opacity: _opacity,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: TextFormField(
                              key: ValueKey('userName'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 4) {
                                  return 'Please enter atleast 4 characters';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Username'),
                              onSaved: (value) {
                                _userName = value;
                              },
                            ),
                          ),
                        ),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password Must be atleast 7 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              icon: _passwordVisible
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              })),
                      obscureText: !_passwordVisible,
                      onSaved: (value) {
                        _userPass = value;
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'SignUp'),
                      ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          // setState(() {
                          //   _isLogin = !_isLogin;
                          // });
                          _switchAuthMode();
                        },
                        child: Text(_isLogin
                            ? 'Create New Account'
                            : 'I already have an account'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
