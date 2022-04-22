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
  final int isComplete;
  final int budgetCategoryId;

  Task({
    required this.id,
    required this.task,
    required this.dueDate,
    required this.description,
    required this.spouse,
    required this.cost,
    required this.isComplete,
    required this.budgetCategoryId,
  });

  //this is a factory constructor that creates a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        task: json['task_title'],
        dueDate: json['due_date'],
        description: json['task_description'],
        spouse: json['assigned_user'],
        cost: json['task_price'],
        isComplete: json['is_complete'],
        budgetCategoryId: json['budget_category_id'],
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
      throw Exception('Failed to load task');
    }
  }

  static Future<List<Task>> fetchAllTasks(String userEmail) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/tasks/$userEmail'));
    var jsonData = jsonDecode(response.body);
    List<Task> tasksList = [];

    // With the json data, convert it to a Task and add it to our tasks list
    for (var json in jsonData['all_tasks']) {
      Task task = Task(
          id: json['id'],
        task: json['task_title'] ?? '',
        dueDate: json['due_date'] ?? '',
        description: json['task_description'] ?? '',
        spouse: json['assigned_user'],
        cost: json['task_price'] ?? '',
        isComplete: json['is_complete'],
        budgetCategoryId: json['budget_category_id'],
      );
      tasksList.add(task);
    }

    // Return the list of tasks
    return tasksList;
  }

  static Future<List<Task>> fetchAllUserTasks(String userEmail) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/tasks/$userEmail'));
    var jsonData = jsonDecode(response.body);
    List<Task> tasksList = [];

    // With the json data, convert it to a Task and add it to our tasks list
    for (var json in jsonData['user_tasks']) {
      Task task = Task(
        id: json['id'],
        task: json['task_title'] ?? '',
        dueDate: json['due_date'] ?? '',
        description: json['task_description'] ?? '',
        spouse: json['assigned_user'],
        cost: json['task_price'] ?? '',
        isComplete: json['is_complete'],
        budgetCategoryId: json['budget_category_id'],
      );
      tasksList.add(task);
    }

    // Return the list of tasks
    return tasksList;
  }

  static Future<List<Task>> fetchAllPartnerTasks(String userEmail) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/tasks/$userEmail'));
    var jsonData = jsonDecode(response.body);
    List<Task> tasksList = [];

    // With the json data, convert it to a Task and add it to our tasks list
    for (var json in jsonData['partner_tasks']) {
      Task task = Task(
        id: json['id'],
        task: json['task_title'] ?? '',
        dueDate: json['due_date'] ?? '',
        description: json['task_description'] ?? '',
        spouse: json['assigned_user'],
        cost: json['task_price'] ?? '',
        isComplete: json['is_complete'],
        budgetCategoryId: json['budget_category_id'],
      );
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
        'user_id' : userID,
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

  static Future<Task> createTask(
      String task, String dueDate, String description,
      int spouse, String? cost, int userID, int? budgetCategoryId) async {
    final response;
    if(budgetCategoryId == null) { // Case where budget category is null
      response = await http.post(
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
          'user_id': userID,
        }),
      );
    } else {
      response = await http.post(
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
          'user_id': userID,
          'budget_category_id': budgetCategoryId
        }),
      );
    }

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create task.');
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