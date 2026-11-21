// Parameters

// 1. positional: order matters, passed in exact declared order
void positional_parameters(String msg, int line) {
  print("$line: $msg");
}

// 2. named parameters: order doesn't matter ({}) are matched by the label.

// Note: required keyword is mandatory when writing named parameters or use default value instead if you are not using required keyword. Otherwise, dart will think, the parameter is null even if function has true all parameters passed on invoke side.

void named_parameters({required String msg, required int line}) {
  print("$line: $msg");
}

// here no required keyword is needed because we have introduce default parameters, if no default parameters than its mandatory to add required keyword, else dart will raise null value error
void default_parameters({String msg = "", int line = 0}) => print("$line: $msg");

// 3. optional parameters: optional parameters = default parameters that can be written using two approaches as below:

// 3.1. approach 1: we can't introduce [] in this case because when {} is introduced then optional parameters can't be written using [] rather we write them as default parameters
void optional_parameters({required String msg, required int line, int col = 0}) {
  
}

// 3.2. approach 2: positional parameters + subscript notation work, but still you need to add default value to make them optional
void optional_parameters_subscript_syntax(String msg, int line, [int col = 0]) {

}

void main() {
  positional_parameters("A bug!", 55); // msg 55
  named_parameters(line: 10, msg: "A bug!");
}
