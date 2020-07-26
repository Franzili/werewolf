import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'database/userService.dart';
import 'database/lobbyService.dart';
import 'widgets/roleCard.dart';
import 'main/role.dart';
import 'styling/globalTheme.dart';

void main() => runApp(MaterialApp(home: Werewolf()));

class Werewolf extends StatefulWidget {
  @override
  _WerewolfState createState() => _WerewolfState();
}

class _WerewolfState extends State<Werewolf> {
  FirebaseUser user;
  UserService userService;
  LobbyService lobbyService;

  Future<void> connectToFirebase() async {
    final FirebaseAuth authenticate = FirebaseAuth.instance;
    AuthResult result = await authenticate.signInAnonymously();
    user = result.user;

    userService = UserService(user.uid);

    if (!(await userService.checkIfUserExists())) {
      userService.setUserRole(UserRole.Moderator.toString());
    }

/*    Stream userDocumentStream = database.getMyRole();
    userDocumentStream.listen( (documentSnapshot) =>
        print(documentSnapshot.data) );*/
  }

  @override
  void initState() {
    super.initState();
    connectToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Werewolf'),
      ),
      body: FutureBuilder(
        future: connectToFirebase(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return StreamBuilder<DocumentSnapshot>(
              stream: userService.getMyRole(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }
                else {
                  Map<String, dynamic> items = snapshot.data.data;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      String key = items.keys.elementAt(i);
                      return RoleCard(items[key]);
                  });
                }
            },
            );
          }
        },
      ),
    );
  }
}

