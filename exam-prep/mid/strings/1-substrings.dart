// Make them lazy using 'late' if they must remain top-level
String str = "saqibbedar18";

// substring(startIndex, endIndex)
String substr = str.substring(0, str.length - 2); // saqibbedar

int seed = int.parse(str.substring(str.length - 2)); // 2

void main() {
  print("$substr"); // Output: saqibbedar
  print("$seed"); // Output: 18
}