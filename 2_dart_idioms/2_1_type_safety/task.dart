/// Explicit type to check that User [id] is valid. 
class UserId {
  UserId(this.val){
    if(!isUUIDv4(val)) {
      throw const FormatException('Id must be 36 charactars long and be in [UUIDv4] format');
    }
  }
  final String val;
}

/// Explicit type to check that User [name] is valid.
class UserName {
  UserName(this.val) {
    if(val.length < 4 || val.length > 32 || !containsOnlyAlphabetic(val)) {
      throw const FormatException('''Name must be in 4-32 range charactars long 
      and contain only alphabetical letters''');
    }
  }
  final String val;
}

/// Explicit type to check that User [bio] is valid.
class UserBio {
  UserBio(this.val) {
    if(val.length > 255) {
      throw const FormatException('Biography must be no longer than 255 characters.');
    }
  }
  final String val;
}

/// Returns 'true' if [str] contains only Alphabatic symbols.
bool containsOnlyAlphabetic(String str) {
  RegExp pattern = RegExp(r'^[a-zA-Z]+$');
  return pattern.hasMatch(str);
}

/// Returns 'true' if [str] is in [UUIDv4].
bool isUUIDv4(String str) {
  RegExp pattern = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-4[0-9a-fA-F]{3}-[89aAbB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$');
  return pattern.hasMatch(str);
}

class User {
  const User({
    required this.id,
    this.name,
    this.bio,
  });

  final UserId id;

  final UserName? name;

  final UserBio? bio;
}

class Backend {
  getUser(UserId id) async => User(id: id);
  putUser(UserId id, {UserName? name, UserBio? bio}) async {}
}

class UserService {
  UserService(this.backend);

  final backend;

  get(UserId id) async {}
  update(User user) async {}
}

void main() async {
  final User morpheus = User(
    id: UserId('550e8400-e29b-41d4-a716-446655440000'),
    name: UserName('Morpheus'),
    bio: UserBio('Once upon a time i will find the chosen one')
  );
  final Backend backend = Backend();
  final UserService service = UserService(backend);
  service.update(morpheus);
  
  print(morpheus.bio?.val);
}
