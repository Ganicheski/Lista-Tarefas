import 'package:flutter/material.dart';
import 'package:projeto/models/task_model.dart';
import 'package:projeto/services/task_service.dart';

class FormTasks extends StatefulWidget {
  final Task? task;
  final int? index;

  const FormTasks({super.key, this.task, this.index});

  @override
  State<FormTasks> createState() => _FormTasksState();
}

class _FormTasksState extends State<FormTasks> {
  final _formKey = GlobalKey<FormState>(); //declarar que é uma variavel privada
  TaskService taskService = TaskService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String _priority = 'media';

  @override
  void initState() {
    if (widget.task != null) {
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.task != null ? 'Editar Tarefa' : 'Criar Nova Tarefa'),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '*Título não preenchido!';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              print(_titleController.text);
                            },
                            decoration: InputDecoration(
                              label: Text('Título'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' * Descrição não preenchida!';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            maxLength: null,
                            decoration: InputDecoration(
                              label: Text('Descrição'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ))),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Prioridade:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'baixa',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        Text('Baixa'),
                        Radio<String>(
                          value: 'media',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        Text('Média'),
                        Radio<String>(
                          value: 'alta',
                          groupValue: _priority,
                          onChanged: (value) {
                            setState(() {
                              _priority = value!;
                            });
                          },
                        ),
                        Text('Alta'),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String titleNewTask = _titleController.text;
                            String descriptionNewTask =
                                _descriptionController.text;
                            if (widget.task != null && widget.index != null) {
                              await taskService.editTask(
                                  widget.index!,
                                  titleNewTask,
                                  descriptionNewTask,
                                  false,
                                  _priority);
                            } else {
                              await taskService.saveTask(titleNewTask,
                                  descriptionNewTask, false, _priority);
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: Text(widget.task != null
                            ? 'Alterar Tarefa'
                            : 'Adicionar Tarefa'))
                  ],
                ))));
  }
}
