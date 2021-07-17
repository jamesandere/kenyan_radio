import 'dart:convert';

import 'package:collection/collection.dart';

class MyRadioList {
  final List<MyRadio> radios;
  MyRadioList({
      this.radios,
  });

  MyRadioList copyWith({
    List<MyRadio> radios,
  }) {
    return MyRadioList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    return MyRadioList(
      radios: List<MyRadio>.from(map['radios']?.map((x) => MyRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) => MyRadioList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MyRadioList &&
        listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
  final int id;
  final String name;
  final String frequency;
  final String tagline;
  final String description;
  final String url;
  final String icon;
  final String image;
  final String language;
  final String category;
  final int order;

  MyRadio({
      this.id,
      this.name,
      this.frequency,
      this.tagline,
      this.description,
      this.url,
      this.icon,
      this.image,
      this.language,
      this.category,
      this.order,
  });

  MyRadio copyWith({
    int id,
    String name,
    String frequency,
    String tagline,
    String description,
    String url,
    String icon,
    String image,
    String language,
    String category,
    int order,
  }) {
    return MyRadio(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      url: url ?? this.url,
      icon: icon ?? this.icon,
      image: image ?? this.image,
      language: language ?? this.language,
      category: category ?? this.category,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'tagline': tagline,
      'description': description,
      'url': url,
      'icon': icon,
      'image': image,
      'language': language,
      'category': category,
      'order': order,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    return MyRadio(
      id: map['id'],
      name: map['name'],
      frequency: map['frequency'],
      tagline: map['tagline'],
      description: map['description'],
      url: map['url'],
      icon: map['icon'],
      image: map['image'],
      language: map['language'],
      category: map['category'],
      order: map['order'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) => MyRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRadio(id: $id, name: $name, frequency: $frequency, tagline: $tagline, description: $description, url: $url, icon: $icon, image: $image, language: $language, category: $category, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyRadio &&
        other.id == id &&
        other.name == name &&
        other.frequency == frequency &&
        other.tagline == tagline &&
        other.description == description &&
        other.url == url &&
        other.icon == icon &&
        other.image == image &&
        other.language == language &&
        other.category == category &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    frequency.hashCode ^
    tagline.hashCode ^
    description.hashCode ^
    url.hashCode ^
    icon.hashCode ^
    image.hashCode ^
    language.hashCode ^
    category.hashCode ^
    order.hashCode;
  }
}
