import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/provider/sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GG App Test v2"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: <Widget>[
        TextField(
          controller: _emailFilter,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: _passwordFilter,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        )
      ],
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Login'),
            onPressed: _loginPressed,
          ),
          TextButton(
            child: const Text('Or'),
            onPressed: () {},
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(double.infinity, 50)),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            label: const Text('Sign In with Google'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogIn();
            },
          ),
          TextButton(
            child: const Text('Dont have an account? Tap here to register.'),
            onPressed: _formChange,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          TextButton(
            child: const Text('Forgot Password?'),
            onPressed: _passwordReset,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Create an Account'),
            onPressed: _createAccountPressed,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: const Size(double.infinity, 50)),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            label: const Text('Sign In with Google'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogIn();
            },
          ),
          TextButton(
            child: const Text('Have an account? Click here to login.'),
            onPressed: _formChange,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
          )
        ],
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    debugPrint('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed() {
    debugPrint(
        'The user wants to create an accoutn with $_email and $_password');
  }

  void _passwordReset() {
    debugPrint("The user wants a password reset request sent to $_email");
  }
}
