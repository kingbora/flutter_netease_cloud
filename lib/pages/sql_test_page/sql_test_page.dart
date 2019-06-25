import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_netease_cloud/utils/database_helper/client_model.dart';
import 'package:flutter_netease_cloud/utils/database_helper/database_helper.dart';

class SqlTestPage extends StatefulWidget {
  @override
  _SqlTestPageState createState() => _SqlTestPageState();
}

class _SqlTestPageState extends State<SqlTestPage> {
  List<Client> testClients = [
    Client(firstName: "Raouf", lastName: "Rahiche", blocked: false),
    Client(firstName: "Zaki", lastName: "oun", blocked: true),
    Client(firstName: "oussama", lastName: "ali", blocked: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite'),
        elevation: 0.0,
      ),
      body: FutureBuilder<List<Client>>(
        future: DBHelper.db.getAllClients(),
        builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Client item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBHelper.db.deleteClient(item.id);
                  },
                  child: ListTile(
                    title: Text(item.lastName),
                    leading: Text(item.id.toString()),
                    trailing: Checkbox(
                      onChanged: (bool value) {
                        DBHelper.db.blockOrUnblock(item);
                        setState(() {
                          
                        });
                      },
                      value: item.blocked,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Client rnd = testClients[math.Random().nextInt(testClients.length)];
          await DBHelper.db.newClient(rnd);
          setState(() {
            
          });
        },
      ),
    );
  }
}