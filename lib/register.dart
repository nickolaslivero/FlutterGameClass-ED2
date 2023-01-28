import 'package:empreendedorismodigital2/login.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nome, _email, _password;
  String? _accountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (input) =>
                      input == null ? null : 'Insira um nome válido',
                  onSaved: (input) => _nome = input!,
                ),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile(
                      title: const Text("Aluno"),
                      value: "aluno",
                      groupValue: _accountType,
                      onChanged: (value) {
                        setState(() {
                          _accountType = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("Professor"),
                      value: "professor",
                      groupValue: _accountType,
                      onChanged: (value) {
                        setState(() {
                          _accountType = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Já possui conta? Logar Conta'),
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
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print(e);
      }
    }
  }
}
