import 'package:flutter/material.dart';
import '../../shared/class/classService.dart';

class TaskScreen extends StatefulWidget {
  final String classId;

  const TaskScreen({Key? key, required this.classId}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late Future<List<Map<String, String>>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = ClassService().getTasks(widget.classId);
  }

  void _tasksUpdate() {
    setState(() {
      _tasksFuture = ClassService().getTasks(widget.classId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final title = task['title'];
                final content = task['content'];
                final points = task['points'];
                final sender = task['sender'];
                return Card(
                  child: ListTile(
                    title: Text(title ?? ''),
                    subtitle: Text('Pontos: ${points ?? ''} - Enviado por: ${sender ?? ''}'),
                    onTap: () {
                      // TODO: Navegar para a tela da tarefa
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Erro ao carregar as tarefas');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
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
              break;
          }
        },
      ),
    );
  }
}
