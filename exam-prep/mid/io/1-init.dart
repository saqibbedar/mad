import 'dart:io';

void main(){
  stdout.writeln('Enter name');
  String? input = stdin.readLineSync();
  print(input);
}