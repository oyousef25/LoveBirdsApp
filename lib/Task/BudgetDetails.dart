import 'dart:convert';

import 'package:http/http.dart' as http;

class BudgetDetails {
  /// Represents all the information about a budget
  final int totalSpent;
  final int budgetTotal;
  final Map<int, String> budgetCategories;

  BudgetDetails({
    required this.totalSpent,
    required this.budgetTotal,
    required this.budgetCategories
  });

  //this is a factory constructor that creates a budget detail object from JSON
  factory BudgetDetails.fromJson(Map<String, dynamic> json) {
    return BudgetDetails(
        totalSpent: json['total_spent'],
        budgetTotal: json['budget_total'],
        budgetCategories: json['categories']
    );
  }

  static Future<BudgetDetails> fetchBudget(String userEmail) async {
    final response = await http
        .get(Uri.parse('https://oyousef.scweb.ca/lovebirds/api/v1/tasks/$userEmail'));
    var jsonData = jsonDecode(response.body);

    // Create the relationship map
    List<int> categoryIds = [];
    List<String> categoryTypes = [];
    for (var category in jsonData['categories']) {
      categoryIds.add(category['id']);
      categoryTypes.add(category['category_name']);
    }
    var categoryMap = Map<int, String>.fromIterables(categoryIds, categoryTypes);

    // Convert json to budget details
    BudgetDetails budgetDetails = BudgetDetails(
        totalSpent: jsonData['total_spent'],
        budgetTotal: jsonData['budget_total'],
        budgetCategories: categoryMap
    );

    // Return the budget details
    return budgetDetails;
  }
}