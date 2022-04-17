import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Task {
  /// Represents all the information about a Task
  final int id;
  final String task;
  final String dueDate;
  final String description;
  final int spouse;
  final String cost;

  Task({
    required this.id,
    required this.task,
    required this.dueDate,
    required this.description,
    required this.spouse,
    required this.cost
  });

  //this is a factory constructor that creates a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        task: json['task_title'],
        dueDate: json['due_date'],
        description: json['task_description'],
        spouse: json['assigned_user'],
        cost: json['task_price']
    );
  }

  static Future<Task> fetchTask(int id) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning/$id'));

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
          id: json['id'],
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

  static Future<Task> updateTask(int id, String task, String dueDate, String description, int spouse, String cost, int userID) async {
    final response = await http.put(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning/$id'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the task
      body: jsonEncode(<String, dynamic>{
        'task_title': task,
        'due_date': dueDate,
        'task_description': description,
        'assigned_user': spouse,
        'task_price': cost,
        'user_id' : userID
      }),
    );

    if (response.statusCode == 200) {
      print("Success");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update task.');
    }
  }

  static Future<Task> createTask(String task, String dueDate, String description, int spouse, String cost, int userID) async {
    final response = await http.post(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the task
      body: jsonEncode(<String, dynamic>{
        'task_title': task,
        'due_date': dueDate,
        'task_description': description,
        'assigned_user': spouse,
        'task_price': cost,
        'user_id': userID
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create custom vendor.');
    }
  }

  static Future<Task> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning/$id'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the task
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete task.');
    }
  }
}