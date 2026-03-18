class ProfileModel {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String email;

  const ProfileModel({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json, String email) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: email,
    );
  }
}

class ProfileStatsModel {
  final int ordersCount;
  final int reviewsCount;
  final int favoritesCount;

  const ProfileStatsModel({
    this.ordersCount = 0,
    this.reviewsCount = 0,
    this.favoritesCount = 0,
  });
}
