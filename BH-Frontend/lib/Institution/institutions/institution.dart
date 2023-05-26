class Institution {
  final int institution_id;
  final String name;
  final String address;
  final String phoneNumber;
  final String website;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  Institution({
    required this.institution_id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.website,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      institution_id: json['institution_id'] ?? 0,
      name: json['name'] ?? '0',
      address: json['address'] ?? '0',
      phoneNumber: json['phoneNumber'] ?? '0',
      website: json['website'] ?? '0',
      monday: json['monday'] ?? '0',
      tuesday: json['tuesday'] ?? '0',
      wednesday: json['wednesday'] ?? '0',
      thursday: json['thursday'] ?? '0',
      friday: json['friday'] ?? '0',
      saturday: json['saturday'] ?? '0',
      sunday: json['sunday'] ?? '0',
    );
  }
}
