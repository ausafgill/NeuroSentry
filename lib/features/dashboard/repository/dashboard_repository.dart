import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/models/article_model.dart';
import 'package:mental_healthapp/models/consultant_model.dart';
import 'package:mental_healthapp/shared/enums/question_type.dart';

final dashboardRepositoryProvider = Provider((ref) => DashboardRepository());

class DashboardRepository {
  Future<List<ArticleModel>> fetchArticles() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('articles').get();

      return snapshot.docs.map((doc) {
        return ArticleModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ArticleModel>> fetchWorstArticles(QuestionType worstType) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('articles')
              .where('articleType', isEqualTo: worstType.name)
              .get();

      return snapshot.docs.map((doc) {
        return ArticleModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Stream<List<ConsultantModel>> searchConsultants(String query) {
    final CollectionReference consultantsCollection =
        FirebaseFirestore.instance.collection('consultants');

    Stream<QuerySnapshot> querySnapshotStream;
    if (query.isNotEmpty) {
      querySnapshotStream = consultantsCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name',
              isLessThan: query +
                  'z') // Ensure only documents starting with the query are included
          .orderBy('name')
          .snapshots();
    } else {
      querySnapshotStream = consultantsCollection.snapshots();
    }

    return querySnapshotStream.map((snapshot) => snapshot.docs
        .map((doc) =>
            ConsultantModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
