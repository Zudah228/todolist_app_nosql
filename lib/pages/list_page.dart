import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todolistapp/db/task.dart';

import 'completed_page.dart';



class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _validate = false;
  List<Task> tasks = [];
  final TextEditingController eCtrl = TextEditingController();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Task")),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check_box,
                  color: Colors.white),
            onPressed: () async{
              await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CompletedPage(completedtasks: tasks))
              );
              setState(() {

              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[

                Expanded(
                  child: TextField(
                    controller: eCtrl,
                    onSubmitted: (text) {
                      Task newTask = Task(status: false,title: eCtrl.text,addedDate: DateTime.now());
                      tasks.add(newTask);
                      eCtrl.clear();
                      setState(() {
                      });
                    },
                  ),
                ),
                RaisedButton(
                  child: Text("+"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Task newTask = Task(status: false,title: eCtrl.text, addedDate: DateTime.now(), completedDate: null);
                    tasks.add(newTask);
                    eCtrl.clear();
                    setState(() {
                    });

                    }
                ),
              ],
            ),
            Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ObjectKey(tasks[index]),
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        child: ListTile(
                          leading: Icon(Icons.list),
                          title: Text(tasks[index].title),
                          subtitle: Text(DateFormat('MM/dd/yyyy HH:mm').format(tasks[index].addedDate)),
                          trailing: Checkbox(
                          activeColor: Colors.green,
                          value: tasks[index].status,
                          onChanged: (bool check){
                            tasks[index].status = check;
                            tasks[index].completedDate = DateTime.now();
                            setState(() {
                            });
                          },
                        )
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: 'Complete',
                            color: Colors.greenAccent,
                            icon: IconData(58826, fontFamily: 'MaterialIcons'),
                            onTap: () {
                              tasks[index].status = true;
                              tasks[index].completedDate = DateTime.now();
                              setState(() {
                              });
                            },
                          )

                        ],
                      ),
                    );
                  }
                )
              ],
            )
          ],
        ),
      )
    );
  }
}
