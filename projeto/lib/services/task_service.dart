import 'dart:convert';

import 'package:projeto/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  Future<void> saveTask(
      String title, String description, bool isDone, String priority) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task task =
        Task(title: title, description: description, priority: priority);
    tasks.add(jsonEncode(task.toJson()));
    await prefs.setStringList('tasks', tasks);
    print('Adicionado');
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = prefs.getStringList('tasks') ?? [];
    List<Task> tasks = taskStrings
        .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
        .toList();
    return tasks;
  }

  deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(index);
    await prefs.setStringList('tasks', tasks);
  }

  editTask(int index, String title, String description, bool isDone,
      String priority) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    Task updateTask = Task(
        title: title,
        description: description,
        isDone: isDone,
        priority: priority);
    tasks[index] = jsonEncode(updateTask.toJson());
    await prefs.setStringList('tasks', tasks);
  }

  editTaskByCheckBox(int index, bool isDone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];

    Task existingTask = Task.fromJson(jsonDecode(tasks[index]));
    existingTask.isDone = isDone;

    tasks[index] = jsonEncode(existingTask.toJson());
    await prefs.setStringList('tasks', tasks);
    print('Tarefa atualizada com sucesso.');
  }
}
