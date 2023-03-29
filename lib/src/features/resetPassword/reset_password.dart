import 'package:empreendedorismodigital2/src/features/resetPassword/models/resetPasswordServiceAuth.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  PasswordResetScreenState createState() => PasswordResetScreenState();
}

class PasswordResetScreenState extends State<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = ResetPasswordServiceAuth();
  String? _email;

  bool _isEmailValid(String email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
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
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_email != null) {
                      _submit(_email);
                    } else {
                      _formKey.currentState!.validate();
                    }
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(email) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        _service.resetPasswordWithEmail(email);
        Navigator.pop(context);
      } catch (e) {
        //print(e);
      }
    }
  }
}
