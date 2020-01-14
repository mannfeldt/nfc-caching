import 'dart:math';

import 'package:nfc_caching/data/emojis.dart';
import 'package:nfc_caching/models/chip.dart';
import 'package:nfc_caching/models/emoji.dart';

//generea allt som ska vara random.
generateChip() {
  var rng = new Random();

  int rarityIndex = rng.nextInt(100) + 1; //1-100
  int emojiIndex = rng.nextInt(EMOJIS.length) + 1;
  int levelIndex = rng.nextInt(30) + 1;

  Emoji emoji = EMOJIS[emojiIndex];
  ChipRarity rarity = getRarity(rarityIndex);
  int level = getLevel(levelIndex);

  return Chip(emoji: emoji, rarity: rarity, level: level);
}

int getLevel(final int rnd) {
  var rng = new Random();
  return rng.nextInt(rnd) + 1;
}

ChipRarity getRarity(final int rnd) {
  if (rnd <= 50) {
    return ChipRarity.Common;
  } else if (rnd <= 50 + 30) {
    return ChipRarity.Uncommon;
  } else if (rnd <= 80 + 12) {
    return ChipRarity.Rare;
  } else if (rnd <= 92 + 6) {
    return ChipRarity.Epic;
  } else {
    return ChipRarity.Legendary;
  }
}
