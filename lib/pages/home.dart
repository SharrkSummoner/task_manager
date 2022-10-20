import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_manager/storage.dart';


class Home extends StatefulWidget {
  const Home({super.key, required this.storage});

  final CounterStorage storage;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userTask;
  List _tasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.storage.readTask().then((value) {
      setState(() {
        _tasks = value;
      });
    });
  }

  Future<File> _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });

    // Write the variable as a string to the file.
    return widget.storage.writeTask(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Task manager'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_tasks[index]),
            child: Card(
              child: ListTile(
                title: Text(_tasks[index]),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _tasks.removeAt(index);
                      print(_tasks);
                    });
                  },
                  icon: IconButton(
                    onPressed: () {
                      setState(() {
                        _tasks.removeAt(index);
                        print(_tasks);
                      });
                    },
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _tasks.removeAt(index);
                print(_tasks);
              });
            },
          );
        },
        itemCount: _tasks.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('New task'),
                  content: TextField(
                    autofocus: true,
                    onChanged: (String value) {
                      setState(() {
                        _userTask = value;
                      });
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _addTask(_userTask);
                            _tasks.add(_userTask);
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('Add'))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
