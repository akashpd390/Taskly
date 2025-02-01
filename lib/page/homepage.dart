import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double _deviceHeight;
  String? _newtexttask;
  Box? _box;
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 141, 222),
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          "Taskly",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
      body: _taskVeiw(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addtask,
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Color.fromARGB(255, 26, 110, 212),
      ),
    );
  }

  Widget _taskVeiw() {
    return FutureBuilder(
      future:Hive.openBox("tasks"), 
      builder: (BuildContext _context, AsyncSnapshot _snapshot,) {
          if (_snapshot.hasData) {
              _box = _snapshot.data;
              return _taskly();
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
      },);
  }

  Widget _taskly() { 
    List _tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (BuildContext _context, int index) {
        var task = Task.fromMap(_tasks[index]);
        return _lsittile(task, index);
      },);
  }

  Widget _lsittile(Task _task,int index) => ListTile(
        title: Text(
          "${index+1}. ${_task.content}",
          style: TextStyle(decoration: _task.done ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text(
          _task.timestamp.toString(),
        ),
        onTap: () {
          setState(() {
          _task.done =! _task.done;
          _box!.putAt(index, _task.toMap());
            
          });
        },
        onLongPress: () {
          _box!.deleteAt(index);
          setState(() {
            
          });
        },
        trailing: Icon( _task.done ? Icons.check_box_outlined : Icons.check_box_outline_blank_outlined),
      );

  void _addtask() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: TextField(
            onSubmitted: (_) {
              if (_newtexttask != null) {
                var _task = Task(content: _newtexttask!, timestamp: DateTime.now(), done: false);
                _box!.add(_task.toMap());
                setState(() {
                  _newtexttask = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newtexttask = _value;
              });
            },
          ),
        );
      },
    );
  }
}
