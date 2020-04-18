class Emoji {
  int id;
  String code;
  EmojiCategory category;
  EmojiRarity rarity;

  Emoji(final int id, final String code, final EmojiCategory category,
      final EmojiRarity rarity) {
    this.id = id;
    this.code = code;
    this.category = category;
    this.rarity = rarity;
  }
  String get rarityName {
    return rarity.toString().split('.')[1];
  }
}

enum EmojiCategory {
  Smiley,
  People,
  Animal,
  Nature,
  Travel,
  FoodDrink,
  SymbolFlag,
  Activity,
  Object
}
enum EmojiRarity {
  Common,
  Uncommon,
  Rare,
  Epic,
  Legendary,
}
