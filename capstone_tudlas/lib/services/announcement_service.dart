import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/dummy_data.dart';
import '../models/announcement.dart';

class AnnouncementService {
  final _col = FirebaseFirestore.instance.collection('announcements');

  // READ (live updates)
  Stream<List<Announcement>> getAnnouncements() {
    return _col
        .orderBy('datePosted', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Announcement.fromDoc).toList());
  }

  // CREATE
  Future<void> add(String title, String body) {
    return _col.add({
      'title': title,
      'body': body,
      'datePosted': FieldValue.serverTimestamp(),
    });
  }

  // UPDATE
  Future<void> update(String id, String title, String body) {
    return _col.doc(id).update({'title': title, 'body': body});
  }

  // DELETE
  Future<void> delete(String id) => _col.doc(id).delete();

  // One-time: upload your 10 dummy announcements
  Future<void> seed() async {
    final batch = FirebaseFirestore.instance.batch();
    for (final a in dummyAnnouncements) {
      batch.set(_col.doc(), {
        'title': a.title,
        'body': a.body,
        'datePosted': Timestamp.fromDate(a.datePosted),
      });
    }
    await batch.commit();
  }
}