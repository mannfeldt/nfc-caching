class Emoji {
  int id;
  String code;
  EmojiCategory category;

  Emoji(final int id, final String code, final EmojiCategory category) {
    this.id = id;
    this.code = code;
    this.category = category;
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
