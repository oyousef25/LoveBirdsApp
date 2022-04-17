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
        name: json['name'],
        description: json['description'],
        rating: json['rating'],
        website: json['website'],
        location: json['location'],
        phoneNum: json['phoneNum'],
        image: json['image']
    );
  }
}