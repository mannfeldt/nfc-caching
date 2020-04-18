import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nfc_caching/data/emojis.dart';
import 'package:nfc_caching/models/emoji.dart';
import 'package:nfc_caching/utils/generator.dart';

class ChipData {
  String key;
  String serialNr;
  Emoji emoji;
  int level;
  String name;
  String comment;
  LatLng coordinates;
  String finder;
  DateTime date;

  ChipData(
      {final String key,
      final String serialNr,
      final int level,
      final Emoji emoji,
      final String name,
      final String comment,
      final LatLng coordinates,
      final String finder,
      final DateTime date}) {
    this.key = key;
    this.serialNr = serialNr;
    this.level = level;
    this.emoji = emoji;
    this.name = name;
    this.comment = comment;
    this.coordinates = coordinates;
    this.finder = finder;
    this.date = date;
  }

  factory ChipData.fromTagging(
      final String serialNr, final LatLng coordinates) {
    ChipData chip = generateChip();
    chip.serialNr = serialNr;
    chip.coordinates = coordinates;
    chip.date = DateTime.now();
    return chip;
  }

  factory ChipData.fromJson(Map<String, dynamic> json) {
    double latitude = json['lat'];
    double longitude = json['lng'];
    LatLng coordinates = LatLng(latitude, longitude);
    int level = json['lv'];
    String key = json['key'];
    Emoji emoji = EMOJIS.firstWhere((e) => e.id == json['emoji']);
    String comment = json['comment'];
    String name = json['name'];
    String serialNr = json['serialNr'];
    String finder = json['finder'];

    return ChipData(
        key: key,
        serialNr: serialNr,
        level: level,
        emoji: emoji,
        name: name,
        comment: comment,
        coordinates: coordinates,
        finder: finder);
  }

  String get title {
    return "${this.emoji.code} ${this.serialNr}";
  }

  String get subtitle {
    return "Lv $level - ${emoji.rarityName}";
  }
}
