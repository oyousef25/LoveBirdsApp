import 'dart:ffi';

class TaskInfo {
  /// Represents all the information about a Task
  final String task;
  final String dueDate;
  final String description;
  final String spouse;
  final Double cost;

  TaskInfo(this.task, this.dueDate, this.description, this.spouse, this.cost);
}