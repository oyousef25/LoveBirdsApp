class PartnerInfo {
  /// Represents all the information about a partner
  final int? id;
  final String? name;
  final String? email;

  const PartnerInfo({required this.id, required this.name,
    required this.email});

  // Create a partner info from json data
  factory PartnerInfo.fromJson(Map<String, dynamic> json) {
    return PartnerInfo(
      id: json['partner']['id'],
      name: json['partner']['name'],
      email: json['partner']['email'],
    );
  }
}