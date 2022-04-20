class AccountInfo {
  /// Represents all the information about an Account
  final int id;
  final String name;
  final String email;
  final String partnerEmail;
  final String budget;
  final String weddingDate;
  final int userTasks;
  final int partnerTasks;
  final int? partnerId;
  final String? partnerName;

  const AccountInfo({required this.id, required this.name,
    required this.email, required this.partnerEmail,
    required this.budget, required this.weddingDate,
    required this.userTasks, required this.partnerTasks,
    required this.partnerId, required this.partnerName});

  // Create an account info from json data
  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    // Hack to determine if the user has an assigned partner
    // jsonPartner will be a Map if there is an assigned partner, a List if there is not
    var jsonPartner = json['partner']; // May be a list or map
    int? tempPartnerId = null;
    String? tempPartnerName = null;
    if(jsonPartner.isNotEmpty) { // Map and List both have the property isNotEmpty
      // Case where json['partner'] returns a Map (meaning it does contain a value)
      tempPartnerId = json['partner']['id'];
      tempPartnerName = json['partner']['name'];
    }

    return AccountInfo(
      id: json['user']['id'],
      name: json['user']['name'] ?? '',
      email: json['user']['email'] ?? '',
      partnerEmail: json['user']['partner_email'] ?? '',
      budget: json['user']['budget'] ?? '',
      weddingDate: json['user']['wedding_date'] ?? '',
      userTasks: json['user_tasks'] ?? 0,
      partnerTasks: json['partner_tasks'] ?? 0,
      partnerId: tempPartnerId,
      partnerName: tempPartnerName,
    );
  }
}