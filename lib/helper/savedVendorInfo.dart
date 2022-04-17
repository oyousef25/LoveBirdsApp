class SavedVendorInfo {
  /// Represents all the information about a saved vendor
  final int id;
  final String name;
  final String description;
  final String rating;
  final String website;
  final String location;
  final String phoneNum;
  final String image;

  const SavedVendorInfo({required this.id, required this.name,
    required this.description, required this.rating,
    required this.website, required this.location,
    required this.phoneNum, required this.image});

  // Create a saved vendor info from json data
  factory SavedVendorInfo.fromJson(Map<String, dynamic> json) {
    return SavedVendorInfo(
        id: json['id'],
        name: json['vendor_title'],
        description: json['vendor_description'],
        rating: json['vendor_rating'],
        website: json['vendor_website'],
        location: json['vendor_location'],
        phoneNum: json['vendor_phone'],
        image: json['vendor_image']
    );
  }
}