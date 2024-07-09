class TaskModel {
  String id;
  String title;
  String Description;
  int date;
  bool isDone;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.Description,
      required this.date,
      required this.userId,
      this.isDone = false});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json["title"],
            Description: json["Description"],
            date: json['date'],
            isDone: json['isDone'],
            userId: json['userId'],
            id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "Description": Description,
      "date": date,
      "isDone": isDone,
      "id": id,
      "userId": userId,
    };
  }
// orr
// TaskModel fromJson(Map<String, dynamic> json) {
//   return TaskModel(
//       title: json["title"],
//       Description: json["Description"],
//       date: json['date'],
//       isDone: json['isDone'],
//       id: json['id']);
// }
}
