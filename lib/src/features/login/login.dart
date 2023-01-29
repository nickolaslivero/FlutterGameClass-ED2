import 'package:empreendedorismodigital2/src/features/home/homeScreen.dart';
import 'package:empreendedorismodigital2/src/features/register/register.dart';
import 'package:empreendedorismodigital2/src/features/resetPassword/reset_password.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  bool _isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  bool _isPasswordValid(String password) => password.length >= 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (input) {
                    if (input!.isEmpty || !_isEmailValid(input)) {
                      return 'Insira um email válido';
                    }
                    return null;
                  },
                  onChanged: (input) => _email = input,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Insira uma senha válida';
                    } else if (!_isPasswordValid(input)) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (input) => _password = input,
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_email != null && _password != null) {
                      _submit(_email, _password);
                    } else {
                      _formKey.currentState!.validate();
                    }
                  },
                  child: const Text('Entrar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Não possui conta? Criar Conta'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordResetScreen()),
                    );
                  },
                  child: const Text('Esqueci minha senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(email, password) async {
    print(email);
    print(password);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Autenticação com o servidor
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        //print(e);
      }
    }
  }
}
