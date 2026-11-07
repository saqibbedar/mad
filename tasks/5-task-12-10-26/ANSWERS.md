# Lab: Campus Library System - Reflection Answers

**Name:** Muhammad Saqib  
**Roll No:** 04072313037  
**Seed:** 37 (t=3, u=7)  

## Reflection Questions

### Q1. What can a subclass using extends use for free that a class using implements has to write itself?

**Answer:** A subclass using extends inherits all concrete method implementations, fields, and default behavior from the parent class for free without re-writing them. In contrast, a class using implements only treats the target class as a pure interface/contract and inherits zero implementation, forcing the class to write its own implementation for every single field, getter, setter, and method.

### Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?

**Answer:** You should pick a mixin when you want to share reusable code and state horizontally across distinct, unrelated branches of a class hierarchy without forcing an "is-a" relationship (e.g., both Book and Dvd can renew, but Magazine cannot). You should pick an abstract parent class when the classes share a foundational identity and common core contract (an "is-a" relationship, such as Book and Magazine both being LibraryItems).

### Q3. Why must you override hashCode whenever you override ==?

**Answer:** Hash-based collections (such as Set and Map) use an object's hashCode to determine which hash bucket it belongs to before testing for equality with ==. If two objects evaluate to equal under == but return different hashCode values (by inheriting identity hash codes from Object), the collection will look in different buckets, failing to find existing elements and allowing duplicate entries.

### Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

**Answer:** Dart disallows subclassing String because it is marked final to protect its immutability, underlying VM memory optimizations, and internal representation guarantees. Extension methods, on the other hand, are resolved statically at compile time as syntactic sugar—they add callable methods without modifying the underlying class's memory layout, runtime type, or security guarantees.