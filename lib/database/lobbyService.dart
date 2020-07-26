import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Werewolf/main/gameState.dart';

class LobbyService {

  final String lobbyID;

  LobbyService(this.lobbyID);

  final CollectionReference lobby = Firestore.instance.collection('lobby');

  // if document with name lobbyID exists, return true, otherwise create one
  Future checkIfLobbyExists() async {
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

  // Add a new user to the lobby with a specific lobbyID
  Future setNewLobby(String lobbyID, String gameStateID) async {
    var phase;
    return lobby.document(lobbyID).collection('gameState').document(gameStateID)
        .setData({
      phase: GameState.Day.toString()
    });
  }

  // Get the IDs of all players in the current lobby
  Future getAllPlayers() async {
    return await lobby.document(lobbyID).collection('user').getDocuments();
  }
}