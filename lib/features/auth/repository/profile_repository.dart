import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/models/profile_model.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserProfile? profile;

  Future<void> saveProfile(UserProfile profile) async {
    try {
      await _firestore.collection('users').doc(profile.profileId).set(
            profile.toMap(),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future getUserProfile() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      UserProfile userProfile = UserProfile.fromMap(snapshot.data()!);
      if (userProfile.todayCompletionDateTime != null &&
          userProfile.todayCompletionDateTime!
              .isBefore(DateTime.now().subtract(const Duration(hours: 24)))) {
        userProfile.todayNutritionScore = null;
        userProfile.todaySleepScore = null;
        userProfile.todayMoodScore = null;
        userProfile.todayThoughtsScore = null;
        userProfile.averageScore = null;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update(userProfile.toMap());
      }
      profile = userProfile;
    }
  }

  Future<void> updateUserScores() async {
    profile!.todayCompletionDateTime = DateTime.now();

    int? totalScore = profile!.todayNutritionScore! +
        profile!.todaySleepScore! +
        profile!.todayMoodScore! +
        profile!.todayThoughtsScore!;
    double averageScore = totalScore / 4;
    profile!.averageScore = averageScore;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(profile!.profileId)
        .set(profile!.toMap());

    // Store average score in history
    await FirebaseFirestore.instance.collection('scoreHistory').add(
      {
        'userId': profile!.profileId,
        'averageScore': averageScore,
        'timestamp': Timestamp.now(),
      },
    );
  }
}
