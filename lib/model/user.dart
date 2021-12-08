import 'dart:convert';

import 'package:phonebook/utils/json_reader.dart';

class User {
  final int id;
  final String avatar;
  final String name;
  final DateTime createdAt;

  User({
    required this.id,
    required this.avatar,
    required this.name,
    required this.createdAt,
  });

  User copyWith({
    int? id,
    String? avatar,
    String? name,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar': avatar,
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: JsonReader(map['id']).asInt(),
      avatar: map['avatar'],
      name: map['name'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, avatar: $avatar, name: $name, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.avatar == avatar &&
        other.name == name &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ avatar.hashCode ^ name.hashCode ^ createdAt.hashCode;
  }
}
