import 'dart:async';

class Database<T> {
  final Map<String, T> _table = {};
  final StreamController<Map<String, T>> _changesController =
      StreamController<Map<String, T>>.broadcast();

  Stream<Map<String, T>> get changes => _changesController.stream;

  Future<void> add(T n) async {
    await Future.delayed(Duration(seconds: 1), () {
      _table[n.toString()] = n;
      _changesController.add(Map<String, T>.from(_table));
    });
  }

  Future<T?> get(String key) async {
    await Future.delayed(Duration(seconds: 1));
    return _table[key];
  }
}

void main() async {
  final database = Database();

  database.changes.listen((data) {
    print('Db changes: $data');
  });

  await database.add(1);
  await database.add('5');

  final res = await database.get('5');
  print(res);
}
