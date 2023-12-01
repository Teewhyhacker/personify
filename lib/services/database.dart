import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personify_app/models/reportmodel.dart';

import 'package:personify_app/models/usermodel.dart';

class DatabaseService {
  final uid;
  DatabaseService({this.uid});

  final CollectionReference reportCollection =
      FirebaseFirestore.instance.collection("reports");

  final CollectionReference personalInformation =
      FirebaseFirestore.instance.collection("Personal Information");

  Future updateUserData(String email, String userName, int age, String state,
      String country, String gender) async {
    return await personalInformation.doc(uid).set({
      "email": email,
      "userName": userName,
      "age": age,
      "state": state,
      "country": country,
      "gender": gender
    });
  }

  Future AddReport(
      String? user, String title, String department, String content) async {
    return await reportCollection.doc().set({
      "title": title,
      "department": department,
      "content": content,
      "report owner": user
    });
  }

  Future updateUserDataProfile(String userName, int age, String state,
      String country, String? gender) async {
    return await personalInformation.doc(uid).update({
      "userName": userName,
      "age": age,
      "state": state,
      "country": country,
      "gender": gender
    });
  }

  UserDataModel _userDataFromFirebaseFirestore(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: uid,
      userName: snapshot.get("userName").toString(),
      email: snapshot.get("email").toString(),
      age: int.parse(snapshot.get("age").toString()),
      state: snapshot.get("state").toString(),
      country: snapshot.get("country").toString(),
      gender: snapshot.get("gender").toString(),
    );
  }

// get UserData doc stream
  Stream<UserDataModel> get userData {
    return personalInformation
        .doc(uid)
        .snapshots()
        .map(_userDataFromFirebaseFirestore);
  }

  List<ReportModel> _reportFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ReportModel(
          title: doc.get("title").toString(),
          department: doc.get("department").toString(),
          content: doc.get("content").toString(),
          reportOwner: doc.get("report owner").toString());
    }).toList();
  }

  // get report stream
  Stream<List<ReportModel>> get reports {
    return reportCollection.snapshots().map(_reportFromSnapshot);
  }
}
