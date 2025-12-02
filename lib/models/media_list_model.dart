import 'package:aiyurapp/models/media_list_item_model.dart';

class MediaListModel {
  final String listName;
  final List<MediaListItemModel> mediaList;

  MediaListModel({
    required this.listName,
    required this.mediaList,
  });

  factory MediaListModel.fromJson(Map<String, dynamic> json) {
    return MediaListModel(
      listName: json['listName'],
      mediaList: (json['mediaList'] as List<dynamic>)
          .map((item) => MediaListItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'listName': listName,
      'mediaList': mediaList.map((e) => e.toJson()).toList(),
    };
  }

  MediaListModel copyWith({
    String? listName,
    List<MediaListItemModel>? mediaList,
  }) {
    return MediaListModel(
      listName: listName ?? this.listName,
      mediaList: mediaList ?? this.mediaList,
    );
  }
}
