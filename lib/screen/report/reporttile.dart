import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:personify_app/models/reportmodel.dart';
import 'package:provider/provider.dart';

class ReportTile extends StatefulWidget {
  final report;
  ReportTile({super.key, this.report});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(widget.report.reportOwner),
          subtitle: Text(widget.report.content),
          trailing: Text(widget.report.department),
        ),
      ),
    );
  }
}
