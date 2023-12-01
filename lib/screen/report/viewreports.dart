import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personify_app/models/reportmodel.dart';
import 'package:personify_app/screen/report/reportlist.dart';
import 'package:personify_app/services/database.dart';
import 'package:provider/provider.dart';

class ViewReportPage extends StatefulWidget {
  const ViewReportPage({super.key});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ReportModel>>.value(
      initialData: [],
      value: DatabaseService().reports,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, bottom: 25),
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
                child: Text(
              "REPORTS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),
          Expanded(
            child: ReportList(),
          ),
        ],
      ),
    );
  }
}
