import 'package:nfc_caching/models/emoji.dart';

//kanske är roligare om vissa emojis är rare av sin natur. får typa upp varje emoji här med sin rarity.
//då behöver jag inte skapa rarity i databasen heller.
final List<Emoji> EMOJIS = [
  Emoji(0, '😀', EmojiCategory.Smiley, EmojiRarity.Common),
  Emoji(0, '👨‍🍳', EmojiCategory.People, EmojiRarity.Rare),
  Emoji(0, '🦊', EmojiCategory.Animal, EmojiRarity.Legendary),
  Emoji(0, '🌵', EmojiCategory.Nature, EmojiRarity.Epic),
  Emoji(0, '🍕', EmojiCategory.FoodDrink, EmojiRarity.Rare),
  Emoji(0, '🏈', EmojiCategory.Activity, EmojiRarity.Epic),
  Emoji(0, '🏖', EmojiCategory.Travel, EmojiRarity.Uncommon),
  Emoji(0, '🧢', EmojiCategory.Object, EmojiRarity.Uncommon),
  Emoji(0, '🇧🇷', EmojiCategory.SymbolFlag, EmojiRarity.Common),
];
