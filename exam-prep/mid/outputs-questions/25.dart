// enums: a fixed set of named choices

enum status { pending, active, done }

// enum is same like an ordinary class, it has attributes and constructor too that we can utilize as below
enum Status2 {
  pending('Pending', false),
  active('In progress', false),
  done('Completed', true);

  // attributes
  final String label;
  final bool isFinished;
  const Status2(this.label, this.isFinished);
}

void main() {
  var a = status.active;
  print(a);
}
