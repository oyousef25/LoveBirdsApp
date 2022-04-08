class CustomVendorInfo {
  /// Represents all the information about a custom vendor
  final String name;
  final String description;
  final String phoneNum;
  // final String location;
  final String vendorType;

  // CustomVendorInfo(this.name, this.description, this.phoneNum, this.location, this.vendorType);
  const CustomVendorInfo({required this.name, required this.description, required this.phoneNum, required this.vendorType});

  // Create a custom vendor info from json data
  factory CustomVendorInfo.fromJson(Map<String, dynamic> json) {
    return CustomVendorInfo(
      name: json['vendor_name'],
      description: json['vendor_description'],
      phoneNum: json['phone_number'],
      vendorType: json['job_title'],
    );
  }
}