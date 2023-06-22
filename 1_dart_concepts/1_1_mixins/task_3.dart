/// Object equipable by a [Character].
abstract class Item {}

/// Mixin for weapons that provide a damage property.
mixin Weapon on Item {
  int get damage;
}

/// Mixin for armor that provide a defense property.
mixin Armor on Item {
  int get defense;
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
    Iterable<Item> equippedWeapons = equipped.whereType<Weapon>();
    return equippedWeapons.fold(0, (sum, weapon) => sum + (weapon as Weapon).damage);
  }

  /// Returns the total defense of this [Character].
  int get defense {
    Iterable<Item> equippedArmor = equipped.whereType<Armor>();
    return equippedArmor.fold(0, (sum, armor) => sum + (armor as Armor).defense);
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
      
      if (item is Hat) {
        
        if(hat == null) {
          hat = item;
        } else if (hat is Helmet) {
          
          item.defense = item.defense + 5;
          
          hat = item;
        } else {
          throw OverflowException();
        }
        
        
      } else if (item is Helmet) {
        
        if(hat == null) {
          hat = item;
          
        } else if (hat is Hat) {
          item.defense += 1;
          hat = item;
        } else {
          throw OverflowException();
        }
        
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

/// Example weapon class implementing the [Weapon] mixin.
class Sword extends Item with Weapon {
  @override
  int get damage => 10;
}

/// Example armor class implementing the [Armor] mixin.
class Helmet extends Item with Armor {
  int _defense = 5;
  @override
  int get defense => _defense;
  set defense (value) {
    _defense = value;
  }
}

class Hat extends Item with Armor {
  int _defense = 1;
  @override
  int get defense => _defense;
  set defense (value) {
    _defense = value;
  }
}

class Torso extends Item with Armor {
  @override
  int get defense => 10;
}

class Legs extends Item with Armor {
  @override
  int get defense => 7;
}

class Shoes extends Item with Armor {
  @override
  int get defense => 2;
}

void main() {
  var character = Character();
  var sword = Sword();
  var helmet = Helmet();
  var hat = Hat();
  
  
  try {
    character.equip(sword);
    character.equip(sword);
    
    character.equip(hat);
    character.equip(helmet);
    
    
    
  } catch (e) {
    if (e is OverflowException) {
      print("Equipment slot is already occupied.");
      return;
    } else {
      print("An error occurred while equipping the item: $e");
      return;
    }
  }
  
  print(character.damage);  
  print(character.defense); 
}
