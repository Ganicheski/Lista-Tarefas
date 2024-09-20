import 'package:flutter/material.dart';
import 'package:projeto/models/task_model.dart';
import 'package:projeto/services/task_service.dart';
import 'package:projeto/views/formulario.dart';

class ListViewTasks extends StatefulWidget {
  const ListViewTasks({super.key});

  @override
  State<ListViewTasks> createState() => _ListViewTasksState();
}

class _ListViewTasksState extends State<ListViewTasks> {
  TaskService taskService = TaskService();
  List<Task> tasks = [];

  getAllTasks() async {
    tasks = await taskService.getTasks();

    setState(() {});
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Tarefas'),
        ),
        body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              bool localIsDone = tasks[index].isDone ?? false;

              Color priorityColor;
              switch (tasks[index].priority) {
                case 'alta':
                  priorityColor = Colors.red;
                  break;
                case 'media':
                  priorityColor = Colors.orange;
                  break;
                case 'baixa':
                  priorityColor = Colors.green;
                  break;
                default:
                  priorityColor =
                      Colors.black; // cor padrão caso algo não esteja definido
              }

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tasks[index].title.toString(),
                            style: TextStyle(
                                decoration: localIsDone
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor:
                                    localIsDone ? Colors.red : null,
                                color: localIsDone ? Colors.grey : Colors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        Checkbox(
                            value: tasks[index].isDone ?? false,
                            onChanged: (value) {
                              if (value != null) {
                                taskService.editTaskByCheckBox(index, value);
                              }
                              setState(() {
                                tasks[index].isDone = value;
                              });
                            }),
                      ],
                    ),
                    Text(
                      tasks[index].description.toString(),
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await taskService.deleteTask(index);
                            getAllTasks();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: localIsDone ? Colors.grey : Colors.red,
                          ),
                        ),
                        if (!localIsDone)
                          IconButton(
                              onPressed: () async {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FormTasks(
                                                task: tasks[index],
                                                index: index)))
                                    .then((value) => getAllTasks());
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 8, left: 5),
                      child: Text(
                        'Prioridade: ${tasks[index].priority}',
                        style: TextStyle(
                          fontSize: 20,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
