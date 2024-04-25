class Batch {
  final String id;
  final String name;
  final String courseId;
  final String courseName;
  final String startDate;
  final String endDate;
  final String branchId;
  final String branchName;
  final String uniqueId;

  Batch({
    required this.id,
    required this.name,
    required this.courseId,
    required this.courseName,
    required this.startDate,
    required this.endDate,
    required this.branchId,
    required this.branchName,
    required this.uniqueId,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['_id'],
      name: json['name'],
      courseId: json['course']['_id'],
      courseName: json['course']['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      branchId: json['branch']['_id'],
      branchName: json['branch']['name'],
      uniqueId: json['uniqueId'],
    );
  }
}
