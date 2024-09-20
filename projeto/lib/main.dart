import 'package:flutter/material.dart';
import 'package:projeto/views/ListaTarefas.dart';
import 'package:projeto/views/formulario.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const MyWidget(),
      routes: {
        '/listarTarefas': (context) => ListViewTasks(),
        '/formularTarefas': (context) => FormTasks(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minha Lista de Tarefas'),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text('Gabriel', style: TextStyle(fontSize: 24)),
                  accountEmail: Text('gabriel_ani8@hotmail.com'),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person))),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Listagem de Tarefas'),
                onTap: () {
                  Navigator.pushNamed(context, '/listarTarefas');
                },
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 15, bottom: 30),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/formularTarefas');
                        },
                        child: Icon(Icons.add))))
          ],
        ));
  }
}
