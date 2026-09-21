/// Course Roster Console App - Lab 1

void main() {
    // Part 1: Setup & Welcome
    printWelcome("Course Roster Manager");

    // Part 2: Course & Roster Data
    const int maxCapacity = 4;
    final DateTime createdAt = DateTime.now();
    String courseTitle = 'CS201: Mobile App Development';
    int capacity = maxCapacity;
    double creditHours = 3.0;
    bool isOpen = true;
    List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
    Set<String> waitlist = {'Priya', 'Noah'};
    Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};

    print('$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}',);


    // Part 3: Null-Safe Instructor Info
    String? instructorEmail;
    print(instructorEmail ?? 'TBA');

    late String enrollmentCode;
    enrollmentCode = generateCode(courseTitle);
    print('Enrollment code: $enrollmentCode');

    // Deliberate crash exercise:
    print('Instructor email length: ${instructorEmail?.length}');
}

/// Prints a welcome message for application
void printWelcome(String appName) {
    print("=== $appName ===");
}

String generateCode(String title) => title.substring(0, 2).toUpperCase() + '101';