import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:todo_api/todo_api.dart';

import '../../provider/user.profile.provider.dart';
import '../../util/snack.bar.util.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class AccountInfoPage extends ConsumerStatefulWidget {
  AccountInfoPage({super.key});

  @override
  _AccountInfoPageState createState() => new _AccountInfoPageState();
}

class _AccountInfoPageState extends ConsumerState<AccountInfoPage> {
  @override
  Widget build(BuildContext context) {
    var userProfileDataProvider = ref.watch(userProfileStateProvider);

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
              icon: const Icon(Icons.refresh),
              onPressed: () {
                ref.read(userProfileStateProvider.notifier).refresh();
              }),
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
          userProfileDataProvider.when(
              data: (data) {
                final List<ListTile> list = List.empty(growable: true);
                final AccountDTO account = data.account!;
                final String dob = DateFormat.yMMMd()
                    .format(DateTime.parse(account.dob.toString()))
                    .toString();

                final List<String?> roles =
                    account.roles!.map((role) => role.name).toList();

                list.add(new ListTile(
                  leading: const Icon(Icons.person),
                  title: new TextFormField(
                    initialValue: "${account.lastName} ${account.firstName}",
                    decoration: new InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                ));
                list.add(new ListTile(
                  leading: const Icon(Icons.phone),
                  title: new TextFormField(
                    initialValue: account.phone ?? '',
                    decoration: new InputDecoration(
                      hintText: "Phone",
                    ),
                  ),
                ));
                list.add(new ListTile(
                  leading: const Icon(Icons.email),
                  title: new TextFormField(
                    initialValue: account.email,
                    decoration: new InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                ));
                list.add(new ListTile(
                  leading: const Icon(Iconsax.key),
                  title: const Text('UserID'),
                  subtitle: Text(
                    account.id.toString(),
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ));
                list.add(new ListTile(
                  leading: const Icon(Icons.label),
                  title: const Text('Nick Name'),
                  subtitle: Text(account.otherName ?? '',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ));
                list.add(new ListTile(
                  leading: const Icon(Icons.today),
                  title: const Text('Birthday'),
                  subtitle: Text(dob),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ));
                list.add(new ListTile(
                  leading: const Icon(Icons.female_outlined),
                  title: const Text('Gender'),
                  subtitle: Text(account.gender!.name),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ));
                list.add(new ListTile(
                    leading: const Icon(Icons.work_history),
                    title: const Text('Position'),
                    subtitle: const Text('Software Developer 2'),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )));
                list.add(new ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Roles'),
                    subtitle: Text(roles.toString())));

                return Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return list[index];
                        }));
              },
              error: (err, s) {
                return ErrorDialog(
                    errorObject: ErrorObject.mapErrorToObject(error: err));
              },
              loading: () => Expanded(child: Center(child: CircularProgressIndicator())))
        ],
      ),
    );
  }
}
