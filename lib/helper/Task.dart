import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Task {
  /// Represents all the information about a Task
  final String task;
  final String dueDate;
  final String description;
  final int spouse;
  final String cost;

  Task({
    required this.task,
    required this.dueDate,
    required this.description,
    required this.spouse,
    required this.cost
  });

  //this is a factory constructor that creates a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        task: json['task_title'],
        dueDate: json['due_date'],
        description: json['task_description'],
        spouse: json['assigned_user'],
        cost: json['task_price']
    );
  }

  static Future<Task> fetchTask() async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Task>> fetchAllTasks() async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning'));
    var jsonData = jsonDecode(response.body);
    List<Task> tasksList = [];

    // With the json data, convert it to a Task and add it to our tasks list
    for (var json in jsonData["tasks"]["data"]) {
      Task task = Task(
          task: json['task_title'],
          dueDate: json['due_date'],
          description: json['task_description'],
          spouse: json['assigned_user'],
          cost: json['task_price']);
      tasksList.add(task);
    }

    // Return the list of tasks
    return tasksList;
  }
}