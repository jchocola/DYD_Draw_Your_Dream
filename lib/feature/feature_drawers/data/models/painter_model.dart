import 'dart:convert';

import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';

class PainterModel {
  final String id;
  final String authorId;
  final String imageUrl;
  final DateTime createdAt;
  PainterModel({
    required this.id,
    required this.authorId,
    required this.imageUrl,
    required this.createdAt,
  });

  PainterEntity toEntity() => PainterEntity(
    id: id,
    authorId: authorId,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );

 factory PainterModel.fromEntity(PainterEntity entity) => PainterModel(
    id: entity.id,
    authorId: entity.authorId,
    imageUrl: entity.imageUrl,
    createdAt: entity.createdAt,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorId': authorId,
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PainterModel.fromMap(Map<String, dynamic> map) {
    return PainterModel(
      id: map['id'] ?? '',
      authorId: map['authorId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PainterModel.fromJson(String source) => PainterModel.fromMap(json.decode(source));
}
