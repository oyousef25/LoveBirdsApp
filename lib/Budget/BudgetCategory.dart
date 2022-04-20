import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BudgetCategory{
  ///Represents all information about a budget category
  final int id;
  final String category;

  BudgetCategory({
    required this.id,
    required this.category
  });

  //this is a factory constructor that creates a BudgetCategory object from JSON
  factory BudgetCategory.fromJson(Map<String, dynamic> json) {
    return BudgetCategory(
        id: json['id'],
        category: json['category_name'],
    );
  }

  static Future<BudgetCategory> fetchBudgetCategory(int id) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/categories/$id'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BudgetCategory.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load task');
    }
  }

  static Future<List<BudgetCategory>> fetchAllBudgetCategories() async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/categories'));
    var jsonData = jsonDecode(response.body);
    List<BudgetCategory> categoriesList = [];

    // With the json data, convert it to a BudgetCategory and add it to our budget categories list
    for (var json in jsonData) {
      BudgetCategory category = BudgetCategory(
          id: json['id'],
          category: json['category_name'],
      );
      categoriesList.add(category);
    }

    // Return the list of categories
    return categoriesList;
  }

  static Future<Map<String, double>> fetchBudgetCategoriesMap() async {
    // Request the guest data, convert to JSon
    var response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/planning'));
    var jsonData = jsonDecode(response.body);

    // Create the relationship map
    List<double> categoryIds = [];
    List<String> budgetCategories = [];

    for (var json in jsonData['categories']) {
      categoryIds.add(json['id']);
      budgetCategories.add(json['category_name']);
    }

    var budgetCategoryMap = Map<String, double>.fromIterables(budgetCategories, categoryIds);

    // Return the list of budget categories
    return budgetCategoryMap;
  }

  static Future<BudgetCategory> updateBudgetCategory(int id, String category) async {
    final response = await http.put(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/categories/$id'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the budget category
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'category_name': category
      }),
    );

    if (response.statusCode == 200) {
      print("Success");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return BudgetCategory.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update budget category.');
    }
  }

  static Future<BudgetCategory> createBudgetCategory(String category) async {
    final response = await http.post(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/categories'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the budget category
      body: jsonEncode(<String, dynamic>{
        'category_name': category,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return BudgetCategory.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create budget category.');
    }
  }

  static Future<BudgetCategory> deleteBudgetCategory(int id) async {
    final response = await http.delete(
      Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/categories/$id'),
      headers: <String, String>{ // Metadata
        'Content-Type': 'application/json; charset=UTF-8',
      }, // Encode the category
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return BudgetCategory.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete budget category.');
    }
  }
}