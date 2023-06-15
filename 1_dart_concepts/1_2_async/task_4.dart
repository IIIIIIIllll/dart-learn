import 'dart:isolate';


void main() async {
  // Write a program calculating a sum of all prime numbers from 1 to N using
  // [Isolate]s to speed up the algorithm.
  final isolateRes = await Isolate.run(() => calculate(21));
  print(isolateRes);
}

int calculate(int n) {
  int sum = 0;
  for(int i = 1; i < n; i++) {
    if(isPrime(i)) {
      
      sum += i;
    };
  }
  return sum;
}

bool isPrime(int number) {
  if (number <= 1) {
    return false;
  }

  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}
