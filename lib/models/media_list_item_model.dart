class MediaListItemModel {
  final String mediaTitle;
  final String mediaDescription;
  final String mediaId;

  MediaListItemModel({
    required this.mediaTitle,
    required this.mediaDescription,
    required this.mediaId,
  });

  factory MediaListItemModel.fromJson(Map<String, dynamic> json) {
    return MediaListItemModel(
      mediaTitle: json['mediaTitle'],
      mediaDescription: json['mediaDescription'],
      mediaId: json['mediaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mediaTitle': mediaTitle,
      'mediaDescription': mediaDescription,
      'mediaId': mediaId,
    };
  }

  MediaListItemModel copyWith({
    String? mediaTitle,
    String? mediaDescription,
    String? mediaId,
  }) {
    return MediaListItemModel(
      mediaTitle: mediaTitle ?? this.mediaTitle,
      mediaDescription: mediaDescription ?? this.mediaDescription,
      mediaId: mediaId ?? this.mediaId,
    );
  }
}
