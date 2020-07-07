import 'package:flutter/material.dart';
import 'package:todolistapp/db/task.dart';

class CompletedPage extends StatefulWidget {
  final List<Task> completedtasks;

  const CompletedPage({Key key, this.completedtasks}) : super(key: key);


  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Completed Task"))
      ),
      body: Column(
        children: <Widget>[
          ListView.builder (
            shrinkWrap: true,
            itemCount: widget.completedtasks.length,
            itemBuilder: (BuildContext context, int index) {
              if (widget.completedtasks[index].status ==  true) {
                return ListTile(
                    leading: Icon(Icons.list),
                    title: Text(widget.completedtasks[index].title),
                    subtitle: Text(
                        widget.completedtasks[index].completedDate.toString()),
                    trailing: Checkbox(
                      activeColor: Colors.green,
                      value: widget.completedtasks[index].status,
                      onChanged: (bool check) {
                        widget.completedtasks[index].status = check;
                        setState(() {});
                      },
                    )
                );
              } else {
                return Container();
              }
            }
          )
        ],
      ),

    );
  }
}
