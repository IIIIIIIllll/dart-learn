T findMax<T extends Comparable>(List<T> list) {
  if (list.isEmpty) {
    throw ArgumentError('The list cannot be empty.');
  }

  T max = list[0];

  for (int i = 1; i < list.length; i++) {
    if (list[i].compareTo(max) > 0) {
      max = list[i];
    }
  }

  return max;
}

void main() {
  List<int> numbers = [5, 2, 10, 8, 3];
  int maxNumber = findMax(numbers);
  print('Maximum number: $maxNumber');

  List<String> names = ['John', 'Alice', 'Bob', 'David'];
  String maxName = findMax(names);
  print('Maximum name: $maxName');
}
