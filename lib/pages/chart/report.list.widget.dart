import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/pages/chart/pdf.widget.dart';

import '../../provider/reports.provider.dart';
import '../../theme/colors.dart';
import '../errors/error.dialog.dart';
import '../errors/error.object.dart';

class ReportListWidget extends ConsumerStatefulWidget {
  static const String routeName = "/home";

  const ReportListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ReportListWidget> createState() => _ReportListWidget();
}

class _ReportListWidget extends ConsumerState<ReportListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final reportsProvider = ref.watch(reportsStateProvider);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text('Reporting'),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                ))),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: navBar,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .watch(reportsStateProvider.notifier)
                          .downloadReports();
                    },
                    icon: Icon(
                      Icons.get_app_outlined,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Download Reports',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(
                    height: 15,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
                child: reportsProvider.when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.documents.length,
                        itemBuilder: (listContext, index) {
                          return ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              height: 45,
                              width: 45,
                              padding: EdgeInsets.all(0.2),
                              child: Image.asset("assets/pdf.png"),
                            ),
                            title: Text(data.documents[index].fileName!),
                            subtitle: Text(DateFormat.yMMMMd()
                                .add_jm()
                                .format(DateTime.parse(data
                                    .documents[index].timeStamp!
                                    .toString()))
                                .toString()),
                            trailing: Icon(Icons.remove_red_eye_sharp),
                            onTap: () async {
                              final Uint8List? document = await ref
                                  .watch(reportsStateProvider.notifier)
                                  .loadReport(data.documents[index].fileName!);
                              print(data.documents[index].fileName!);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (dialogContext) =>
                                        PdfViewWidget(document: document!),
                                  ));
                            },
                            selected: true,
                          );
                        },
                      );
                    },
                    error: (err, s) => ErrorDialog(
                        errorObject: ErrorObject.mapErrorToObject(error: err)),
                    loading: () => Center(child: CircularProgressIndicator()))),
          ],
        ));
  }
}
