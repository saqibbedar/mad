// Syntax: using datatype
Map<String, int>? Ages;

void main() {
  var ages = {'Saqib': 22, 'Mudasir': 29, 'Muzamil': 38};

  print(ages["Saqib"]);                     // 22
  ages['Mudasir'] = 30;

  print(ages["Mudasir"]);                  // 30

  print(ages.containsKey('Saqib'));       // true

  // looping
  ages.forEach(((key, value) => print("$key, $value")));
}