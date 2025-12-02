import 'package:aiyurapp/models/media_list_model.dart';

class UserModel {
  final String userUid;
  final String nickname;
  final String? biography;
  final List<MediaListModel> mediaLists;

  UserModel({
    required this.userUid,
    required this.nickname,
    this.biography,
    required this.mediaLists,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userUid: json['userUid'],
      nickname: json['nickname'],
      biography: json['biography'],
      mediaLists: (json['mediaLists'] as List<dynamic>)
          .map((item) => MediaListModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userUid': userUid,
      'nickname': nickname,
      'biography': biography,
      'mediaLists': mediaLists.map((e) => e.toJson()).toList(),
    };
  }

  UserModel copyWith({
    String? userUid,
    String? nickname,
    String? biography,
    List<MediaListModel>? mediaLists,
  }) {
    return UserModel(
      userUid: userUid ?? this.userUid,
      nickname: nickname ?? this.nickname,
      biography: biography ?? this.biography,
      mediaLists: mediaLists ?? this.mediaLists,
    );
  }
}
