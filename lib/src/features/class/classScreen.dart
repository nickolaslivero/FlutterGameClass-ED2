import 'package:flutter/material.dart';

import '../../shared/class/classService.dart';
import '../task/taskScreen.dart';

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
        title: const Text('Mensagens'),
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
                  return const Text('Erro ao carregar as mensagens');
                } else {
                  return const Center(
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
                      decoration: const InputDecoration(
                        labelText: 'Mensagem',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ClassService().sendMessage(
                            _messageController.text, widget.classId);
                        _messageController.clear();
                        _messagesUpdate();
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Mensagens',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tarefas',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TaskScreen()));
              break;
          }
        },
      ),
    );
  }
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Tarefas a serem feitas:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TaskCard(
                title: 'Tarefa 1',
                description: 'Descrição da tarefa 1',
                date: '20/05/2022',
              ),
              TaskCard(
                title: 'Tarefa 2',
                description: 'Descrição da tarefa 2',
                date: '25/05/2022',
              ),
              TaskCard(
                title: 'Tarefa 3',
                description: 'Descrição da tarefa 3',
                date: '30/05/2022',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(date),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
