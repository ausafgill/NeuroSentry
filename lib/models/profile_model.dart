class UserProfile {
  String profileId;
  String profileName;
  DateTime profileDoB;
  String profileGender;
  int? todayNutritionScore;
  int? todaySleepScore;
  int? todayMoodScore;
  int? todayThoughtsScore;
  DateTime? todayCompletionDateTime;
  double? averageScore;

  UserProfile({
    required this.profileId,
    required this.profileName,
    required this.profileDoB,
    required this.profileGender,
    this.todayNutritionScore,
    this.todaySleepScore,
    this.todayMoodScore,
    this.todayThoughtsScore,
    this.todayCompletionDateTime,
    this.averageScore,
  });

  // Factory method to create a UserProfile object from a map
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      profileId: map['profileId'],
      profileName: map['profileName'],
      profileDoB: DateTime.parse(map['profileDoB']),
      profileGender: map['profileGender'],
      todayNutritionScore: map['todayNutritionScore'],
      todaySleepScore: map['todaySleepScore'],
      todayMoodScore: map['todayMoodScore'],
      todayThoughtsScore: map['todayThoughtsScore'],
      todayCompletionDateTime: map['todayCompletionDateTime'] != null
          ? DateTime.parse(map['todayCompletionDateTime'])
          : null,
      averageScore: map['averageScore'] != null
          ? double.parse(map['averageScore'].toString())
          : null,
    );
  }

  // Method to convert UserProfile object to a map
  Map<String, dynamic> toMap() {
    return {
      'profileId': profileId,
      'profileName': profileName,
      'profileDoB': profileDoB.toIso8601String(),
      'profileGender': profileGender,
      'todayNutritionScore': todayNutritionScore,
      'todaySleepScore': todaySleepScore,
      'todayMoodScore': todayMoodScore,
      'todayThoughtsScore': todayThoughtsScore,
      'todayCompletionDateTime': todayCompletionDateTime?.toIso8601String(),
      'averageScore': averageScore,
    };
  }
}

