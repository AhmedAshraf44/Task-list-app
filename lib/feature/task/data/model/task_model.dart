class TaskModel {
  final String title, status, date;
  final int? id;

  TaskModel(
      {this.id, required this.title, required this.status, required this.date});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        title: json['tittle'],
        status: json['status'],
        date: json['date']);
  }
}
