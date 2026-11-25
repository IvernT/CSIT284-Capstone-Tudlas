import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  final String title;
  final String body;
  final DateTime datePosted;

  Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.datePosted,
  });

  factory Announcement.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Announcement(
      id: doc.id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      // serverTimestamp is briefly null on the device right after a write
      datePosted: (data['datePosted'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}