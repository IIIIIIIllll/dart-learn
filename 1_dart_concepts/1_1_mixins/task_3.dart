/// Object equipable by a [Character].
abstract class Item {}

/// Mixin for items that provide damage.
mixin Weapon on Item {
  int damage = 0;
}

/// Mixin for items that provide defense.
mixin Armor on Item {
  int defense = 0;
}

/// Entity equipping [Item]s.
class Character {
  Item? leftHand;
  Item? rightHand;
  Item? hat;
  Item? torso;
  Item? legs;
  Item? shoes;

  /// Returns all the [Item]s equipped by this [Character].
  Iterable<Item> get equipped =>
      [leftHand, rightHand, hat, torso, legs, shoes].whereType<Item>();

  /// Returns the total damage of this [Character].
  int get damage {
    int totalDamage = 0;
    for (var item in equipped) {
      if (item is Weapon) {
        totalDamage += item.damage;
      }
    }
    return totalDamage;
  }

  /// Returns the total defense of this [Character].
  int get defense {
    int totalDefense = 0;
    for (var item in equipped) {
      if (item is Armor) {
        totalDefense += item.defense;
      }
    }
    return totalDefense;
  }

  /// Equips the provided [item], meaning putting it to the corresponding slot.
  ///
  /// If there's already a slot occupied, then throws a [OverflowException].
  void equip(Item item) {
    if (item is Weapon) {
      if (leftHand == null) {
        leftHand = item;
      } else if (rightHand == null) {
        rightHand = item;
      } else {
        throw OverflowException();
      }
    } else if (item is Armor) {
      if (item is Hat && hat == null) {
        hat = item;
      } else if (item is Helmet && hat == null) {
        hat = item;
      } else if (item is Torso && torso == null) {
        torso = item;
      } else if (item is Legs && legs == null) {
        legs = item;
      } else if (item is Shoes && shoes == null) {
        shoes = item;
      } else {
        throw OverflowException();
      }
    }
  }
}

/// [Exception] indicating there's no place left in the [Character]'s slot.
class OverflowException implements Exception {}

/// Example weapon.
class Sword extends Item with Weapon {
  @override
  int damage;

  Sword(this.damage);
}

/// Example armor.
class Helmet extends Item with Armor {
  @override
  int defense;

  int getDefense() {
    return this.defense;
  }

  Helmet(this.defense);
}

class Hat extends Item with Armor {
  @override
  int defense;

  Hat(this.defense);
}

class Torso extends Item with Armor {
  @override
  int defense;

  Torso(this.defense);
}

class Legs extends Item with Armor {
  @override
  int defense;

  Legs(this.defense);
}

class Shoes extends Item with Armor {
  @override
  int defense;

  Shoes(this.defense);
}

void main() {
  Character character = Character();
  Sword sword = Sword(10);
  Helmet helmet = Helmet(5);
  Shoes shoes = Shoes(2);

  character.equip(sword);
  character.equip(helmet);
  character.equip(shoes);

  print("Total damage: ${character.damage}");
  print("Total defense: ${character.defense}");
}
