// custom exceptions
class DivByZero implements Exception {
  final String message;
  DivByZero(this.message);

  @override
  String toString() => "DivByZero Exception: $message";
}

int safeDivide(int numerator, int denominator) {
  if (denominator == 0) {
    throw DivByZero("You can't divide an integer by zero!");
  }

  return numerator ~/ denominator;
}

void main() {
  try {
    var result = safeDivide(12, 0);
    print(result);
  } on DivByZero catch (e) {
    print("Error: $e");
  }
  
  catch (e) {
    print('Unexpected error: $e');
  } finally {
    print('Done');
  }
}