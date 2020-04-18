import 'dart:math';

import 'package:nfc_caching/data/emojis.dart';
import 'package:nfc_caching/models/chip.dart';
import 'package:nfc_caching/models/emoji.dart';

//generea allt som ska vara random.
ChipData generateChip() {
  var rng = new Random();

  int rarityIndex = rng.nextInt(100) + 1; //1-100
  Emoji emoji = getEmoji(rarityIndex);
  int levelIndex = rng.nextInt(30) + 1;

  int level = getLevel(levelIndex);

  return ChipData(emoji: emoji, level: level);
}

int getLevel(final int rnd) {
  var rng = new Random();
  return rng.nextInt(rnd) + 1;
}

Emoji getEmoji(final int rarityIndex) {
  var rng = new Random();

  EmojiRarity rarity;
  if (rarityIndex <= 50) {
    rarity = EmojiRarity.Common;
  } else if (rarityIndex <= 50 + 30) {
    rarity = EmojiRarity.Uncommon;
  } else if (rarityIndex <= 80 + 12) {
    rarity = EmojiRarity.Rare;
  } else if (rarityIndex <= 92 + 6) {
    rarity = EmojiRarity.Epic;
  } else {
    rarity = EmojiRarity.Legendary;
  }
  List<Emoji> selectableEmojis =
      EMOJIS.where((e) => e.rarity == rarity).toList();

  return selectableEmojis[rng.nextInt(selectableEmojis.length)];
}

// ChipRarity getRarity(final int rnd) {
//   if (rnd <= 50) {
//     return ChipRarity.Common;
//   } else if (rnd <= 50 + 30) {
//     return ChipRarity.Uncommon;
//   } else if (rnd <= 80 + 12) {
//     return ChipRarity.Rare;
//   } else if (rnd <= 92 + 6) {
//     return ChipRarity.Epic;
//   } else {
//     return ChipRarity.Legendary;
//   }
//}
