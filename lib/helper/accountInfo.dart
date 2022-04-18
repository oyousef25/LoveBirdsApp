class AccountInfo {
  /// Represents all the information about an Account
  final int id;
  final String name;
  final String email;
  final String partnerEmail;
  final String budget;
  final String weddingDate;

  const AccountInfo({required this.id, required this.name,
    required this.email, required this.partnerEmail,
    required this.budget, required this.weddingDate});

  // Create an account info from json data
  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      partnerEmail: json['partner_email'],
      budget: json['budget'],
      weddingDate: json['wedding_date'],
    );
  }
}