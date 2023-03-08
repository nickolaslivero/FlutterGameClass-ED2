import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _address;
  String? _selectedGender;
  String? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Salva as informações do usuário
                // e volta para a tela de perfil
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Implementação da seleção de imagem
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  initialValue: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, preencha seu nome';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                  ),
                  initialValue: _address,
                  onChanged: (value) {
                    setState(() {
                      _address = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Gênero',
                  ),
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'masculino',
                      child: const Text('Masculino'),
                    ),
                    DropdownMenuItem(
                      value: 'feminino',
                      child: const Text('Feminino'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
