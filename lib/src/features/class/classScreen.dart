import 'package:flutter/material.dart';

import '../../shared/class/classService.dart';

class MessageScreen extends StatefulWidget {
  final String classId;

  const MessageScreen({Key? key, required this.classId}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<Map<String, String>>> _messagesFuture;
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messagesFuture = ClassService().getMessages(widget.classId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _messagesUpdate() {
    setState(() {
      _messagesFuture = ClassService().getMessages(widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensagens'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final senderName = message['sender'];
                      final content = message['content'];
                      return Card(
                        child: ListTile(
                          title: Text(senderName ?? ''),
                          subtitle: Text(content ?? ''),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao carregar as mensagens');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite uma mensagem';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Mensagem',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ClassService().sendMessage(_messageController.text, widget.classId);
                        _messageController.clear();
                        _messagesUpdate();
                      }
                    },
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Voltar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              break;
          }
        },
      ),
    );
  }
}
