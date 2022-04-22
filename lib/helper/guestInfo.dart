class GuestInfo {
  /// Represents all the information about a Guest
  final int id;
  final String firstName;
  final String lastName;
  final int relationship;
  final String email;
  final String phoneNum;
  final int status;

  const GuestInfo({required this.id, required this.firstName,
      required this.lastName, required this.relationship,
      required this.email, required this.phoneNum, required this.status});

  // Create a guest info from json data
  factory GuestInfo.fromJson(Map<String, dynamic> json) {

    return GuestInfo(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        relationship: json['guest_relationship'],
        email: json['email_address'],
        phoneNum: json['phone_number'],
        status: json['status_id'],
    );
  }
}