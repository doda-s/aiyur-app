import 'package:aiyurapp/models/media_list_item_model.dart';
import 'package:aiyurapp/models/media_list_model.dart';
import 'package:aiyurapp/models/user_model.dart';
import 'package:aiyurapp/modules/database_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  UserService._();
  static final UserService instance = UserService._();
  final DatabaseConfig _databaseConfig = DatabaseConfig.instance;
  late final _database = _databaseConfig.database;
  late final String _collectionName = _databaseConfig.userCollectionName;

  Future<void> registerUserInDatabase(User user) async {
    final UserModel userModel = UserModel(
        userUid: user.uid,
        nickname: user.email!,
        mediaLists: [
          MediaListModel(
              listName: "Favorites",
              mediaList: [],
          )
        ],
    );
    await setUserDocumentInDataBase(userModel);
  }

  Future<void> setUserDocumentInDataBase(UserModel userModel) async {
    if(await checkDocumentByUserUid(userModel.userUid) == null) {
      await _database.collection(_collectionName).doc(userModel.userUid).set(userModel.toJson());
    }
  }

  Future<void> updateUser(UserModel user) async {
    await _database.collection(_collectionName).doc(user.userUid).update(user.toJson());
  }

  Future<DocumentSnapshot?> checkDocumentByUserUid(String? userUid) async {
    if(userUid == null) {
      return null;
    }
    DocumentSnapshot userDoc = await _database.collection(_collectionName).doc(userUid).get();
    if(userDoc.exists) {
      return userDoc;
    }
    return null;
  }

  Future<UserModel?> getUserData(String? userUid) async {
    if(userUid != null) {
      var _doc = await _database.collection(_collectionName).doc(userUid).get();
      var _data = _doc.data();

      UserModel userModel;
      if(_data != null) {
        userModel = UserModel.fromJson(_data);
        print(userModel.toJson());
        return userModel;
      }
    }
    return null;
  }

  Future<void> updateNickname(String uid, String newNickname) async {
    await _database.collection(_collectionName).doc(uid).update({"nickname": newNickname});
  }

  Future<void> updateBiography(String uid, String? newBio) async {
    await _database.collection(_collectionName).doc(uid).update({"biography": newBio});
  }

  Future<void> addMediaItem ({
    required String uid,
    required String listName,
    required MediaListItemModel newItem,
  }) async {
    final user = await getUserData(uid);
    if (user == null) throw Exception("User not found!");

    final novasListas = user.mediaLists.map((lista) {
      if (lista.listName == listName) {
        return lista.copyWith(
          mediaList: [...lista.mediaList, newItem],
        );
      }
      return lista;
    }).toList();
    print(user.toJson());
    final updated = user.copyWith(mediaLists: novasListas);
    print(updated.toJson());

    await updateUser(updated);
  }

  Future<void> removeMediaItem({
    required String uid,
    required String listName,
    required String mediaId,
  }) async {
    final user = await getUserData(uid);
    if (user == null) throw Exception("User not found!");

    final novasListas = user.mediaLists.map((lista) {
      if (lista.listName == listName) {
        return lista.copyWith(
          mediaList: lista.mediaList
              .where((item) => item.mediaId != mediaId)
              .toList(),
        );
      }
      return lista;
    }).toList();

    final updated = user.copyWith(mediaLists: novasListas);

    await updateUser(updated);
  }
}