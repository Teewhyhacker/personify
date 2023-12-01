import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:personify_app/models/usermodel.dart';
import 'package:personify_app/screen/Profile/profile_form.dart';
import 'package:personify_app/screen/authenticate/signin.dart';
import 'package:personify_app/screen/authenticate/signup.dart';
import 'package:personify_app/screen/sharedscreen/LoadingPage.dart';
import 'package:personify_app/screen/wrapper/Wrapper.dart';
import 'package:personify_app/services/AuthService.dart';
import 'package:personify_app/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    bool loading = false;
    final user = Provider.of<UserModel>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
              child: ProfileForm(),
            );
          });
    }

    print(user.uid);
    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserDataModel? Userdata = snapshot.data;
          print(Userdata);
          return Center(
            child: Container(
                child: Column(
              children: [
                const Expanded(flex: 2, child: _TopPortion()),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Center(
                                child: Text(
                                  "${user.displayName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  "${user.email}",
                                ),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "Account Info",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "USER NAME",
                                ),
                                leading: Icon(Icons.person),
                                subtitle: Text("${Userdata!.userName}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: Text(
                                  "AGE",
                                ),
                                leading: Icon(Icons.person),
                                subtitle: Text("${Userdata!.age}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: Text(
                                  "STATE",
                                ),
                                leading: Icon(Icons.person),
                                subtitle: Text("${Userdata!.state}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: Text(
                                  "COUNTRY",
                                ),
                                leading: Icon(Icons.person),
                                subtitle: Text("${Userdata!.country}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                title: Text(
                                  "USER NAME",
                                ),
                                leading: Icon(Icons.person),
                                subtitle: Text("${Userdata!.gender}",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    )),
                              ),
                              Divider(
                                height: 2,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                margin: EdgeInsets.only(left: 90, right: 90),
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () => _showSettingsPanel(),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      Text("Edit data"),
                                    ],
                                  ),
                                ),
                              ),
                              // LogOut button
                              Container(
                                margin: EdgeInsets.only(left: 90, right: 90),
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    dynamic result = await _auth.Logout();

                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      print("can't log out");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => SignIn()));
                                    }
                                  },
                                  child: Text("Log out"),
                                ),
                              ),

                              // Delete accounts
                              Container(
                                margin: EdgeInsets.only(left: 90, right: 90),
                                child: MaterialButton(
                                  color: Colors.blue,
                                  onPressed: () async {
                                    await _auth.DeleteAccount();
                                    dynamic result = await _auth.Logout();

                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      print("can't log out");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => SignIn()));
                                    }
                                  },
                                  child: Text("Delete my Account"),
                                ),
                              ),

                              // Edit Profile
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
        } else {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You have no data"),
              MaterialButton(
                color: Colors.blue,
                onPressed: () async {
                  await _auth.Logout();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => SignIn()));
                },
                child: Text("Register here"),
              )
            ],
          ));
        }
      },
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [],
            ),
          ),
        )
      ],
    );
  }
}
