import 'package:empreendedorismodigital2/home_screen.dart';
import 'package:empreendedorismodigital2/register.dart';
import 'package:empreendedorismodigital2/reset_password.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

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
                  validator: (input) =>
                      !input!.contains('@') ? 'Insira um email válido' : null,
                  onSaved: (input) => _email = input!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (input) => input!.length < 6
                      ? 'A senha deve ter mais de 6 caracteres'
                      : null,
                  onSaved: (input) => _password = input!,
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _submit,
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

  _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Autenticação com o servidor
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        print(e);
      }
    }
  }
}
