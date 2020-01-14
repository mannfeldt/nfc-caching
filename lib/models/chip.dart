import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nfc_caching/data/emojis.dart';
import 'package:nfc_caching/models/emoji.dart';
import 'package:nfc_caching/utils/generator.dart';

class Chip {
  String key;
  String serialNr;
  Emoji emoji;
  int level;
  ChipRarity rarity;
  String name;
  String comment;
  LatLng coordinates;

  Chip(
      {final String key,
      final String serialNr,
      final int level,
      final ChipRarity rarity,
      final Emoji emoji,
      final String name,
      final String comment,
      final LatLng coordinates}) {
    this.key = key;
    this.serialNr = serialNr;
    this.level = level;
    this.rarity = rarity;
    this.emoji = emoji;
    this.name = name;
    this.comment = comment;
    this.coordinates = coordinates;
  }

  factory Chip.fromTagging(final String serialNr, final LatLng coordinates) {
    Chip chip = generateChip();
    chip.serialNr = serialNr;
    chip.coordinates = coordinates;
    return chip;
  }

  factory Chip.fromJson(Map<String, dynamic> json) {
    double latitude = json['lat'];
    double longitude = json['lng'];
    LatLng coordinates = LatLng(latitude, longitude);
    int level = json['lv'];
    String key = json['key'];
    ChipRarity rarity = ChipRarity.values[json['rarity']];
    Emoji emoji = EMOJIS.firstWhere((e) => e.id == json['emoji']);
    String comment = json['comment'];
    String name = json['name'];
    String serialNr = json['serialNr'];

    return Chip(
        key: key,
        serialNr: serialNr,
        level: level,
        rarity: rarity,
        emoji: emoji,
        name: name,
        comment: comment,
        coordinates: coordinates);
  }
}

enum ChipRarity {
  Common,
  Uncommon,
  Rare,
  Epic,
  Legendary,
}
