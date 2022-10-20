import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/firebase_options.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userTask;
  List _tasks = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFirebase();
  }

  void _menuOpen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: Text('To Main')),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Task manager'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _menuOpen();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading data');
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key(snapshot.data!.docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text(snapshot.data!.docs[index].get('item')),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance
                                .collection('items')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          });
                        },
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
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
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
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
                          FirebaseFirestore.instance
                              .collection('items')
                              .add({'item': _userTask});
                          Navigator.of(context).pop();
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
