import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../util/snack.bar.util.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({super.key});

  @override
  _MyAccountPageState createState() => new _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        elevation: 0.2,
        title: new Text("My Account"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                SnackBarUtil.snackBarDismissAndDoNothing(
                    context: context, value: "Account info updated.");
              })
        ],
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: new TextFormField(
              initialValue: "Mothusi Molorane",
              decoration: new InputDecoration(
                hintText: "Name",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.phone),
            title: new TextFormField(
              initialValue: "063 9211 830",
              decoration: new InputDecoration(
                hintText: "Phone",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.email),
            title: new TextFormField(
              initialValue: "molorane@gmail.com",
              decoration: new InputDecoration(
                hintText: "Email",
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Iconsax.key),
            title: const Text('UserID'),
            subtitle: const Text(
              '2014098616',
              style: TextStyle(
                color: Colors.deepOrange,
              ),
            ),
            trailing: const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.label),
            title: const Text('Nick'),
            subtitle: const Text('BSG Flutter'),
          ),
          new ListTile(
            leading: const Icon(Icons.today),
            title: const Text('Birthday'),
            subtitle: const Text('May 4, 1991'),
            trailing: const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
          new ListTile(
              leading: const Icon(Icons.work_history),
              title: const Text('Position'),
              subtitle: const Text('Intermediate Software Developer'),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
