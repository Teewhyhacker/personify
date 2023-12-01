import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personify_app/models/reportmodel.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/report/reporttile.dart';
import 'package:provider/provider.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  @override
  Widget build(BuildContext context) {
    final reports = Provider.of<List<ReportModel>>(context);

    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        if (reports.length == null) {
          return SpinKitChasingDots(
            color: Colors.blue,
          );
        }
        {
          return ReportTile(report: reports[index]);
        }
      },
    );
  }
}
