import 'package:empreendedorismodigital2/src/features/login/login.dart';
import 'package:flutter/material.dart';
import 'models/registerServiceAuthFirestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = RegisterServiceAuthFirestore();
  String? _name, _email, _password, _accountType = 'Aluno';


  bool _isNameValid(String name) => RegExp(r"^[a-zA-Z ]+$").hasMatch(name);
  bool _isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  bool _isPasswordValid(String password) => password.length >= 6;

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
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Insira um nome válido';
                    } else if (!_isNameValid(input)) {
                      return 'Insira um nome sem caracteres especiais ou números';
                    }
                    return null;
                  },
                  onChanged: (input) => _name = input,
                ),
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
                /*
                Column(
                  children: <Widget>[
                    RadioListTile(
                      value: 'Aluno',
                      groupValue: _accountType,
                      title: const Text('Aluno'),
                      onChanged: (value) {
                        setState(() {
                          _accountType = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      value: 'Professor',
                      groupValue: _accountType,
                      title: const Text('Professor'),
                      onChanged: (value) {
                        setState(() {
                          _accountType = value!;
                        });
                      },
                    ),
                  ],
                ),*/
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_name != null && _email != null && _password != null) {
                      _submit(_name, _email, _password, _accountType);
                    } else {
                      _formKey.currentState!.validate();
                    }
                  },
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

  _submit(name, email, password, acctype) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        _service.registerUser(name, email, password);
      } catch (e) {
        // print(e);
      }
    }
  }
}
