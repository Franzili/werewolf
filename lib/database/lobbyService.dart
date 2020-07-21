import 'package:cloud_firestore/cloud_firestore.dart';

class LobbyService {

  final String lobbyID;

  LobbyService(this.lobbyID);

  final CollectionReference lobby = Firestore.instance.collection('lobby');

  // if document with name lobbyID exists, return true, otherwise create one
  Future checkIfUserExists() async {
    if ((await lobby.document(lobbyID).get()).exists) {
      return true;
    } else {
      await lobby.document(lobbyID).setData({
        'lobby does not exist': true,
      });
      return false;
    }
  }

  // return stream with user collections
  Stream<DocumentSnapshot> getDataStream() {
    return lobby.document(lobbyID).snapshots();
  }

  // Add a new user to the current lobby
  Future setNewLobby(String userID, String role) async {
    return await lobby.document(lobbyID).collection('user').document();
  }
}