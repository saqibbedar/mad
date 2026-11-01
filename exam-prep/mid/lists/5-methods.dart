void main() {
  var nums = [3, 1, 2, 3, 7, 4, 5, 6];
  
  print(nums);          // [3, 1, 2, 3, 7, 4, 5, 6]
  
  nums.add(6);
  nums.remove(1);       // remove first 1 found
  nums.sort();          // sort in ascending order 

  print(nums);          // [2, 3, 3, 4, 5, 6, 6, 7]

  nums.contains(6);     // true


  // powerful list methods

  // where returns only matched elements
  print(nums.where((n) => n.isEven));    // (2, 4, 6, 6)
  
  // same js .map func: return exact list but with applied changes
  print(nums.map((n) => n * 2));        // (4, 6, 6, 8, 10, 12, 12, 14)

  // reduce list to a number or anything
  print(nums.reduce((curr, next) => curr + next));  // 36

  // fold: same as reduce but requires additional starting value
  var total = nums.fold(10, (curr, next) => curr + next);
  print(total);   // 46

  // OR, other way to do it in-case if you are using it in print statement
  print(nums.fold<int>(10, (curr, next) => curr + next));   // 46
}