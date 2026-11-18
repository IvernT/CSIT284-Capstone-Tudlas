import 'package:capstone_tudlas/models/announcement.dart';
import 'package:capstone_tudlas/widgets/announcement_cart.dart';
import 'package:flutter/material.dart';

class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [...dummyAnnouncements]
      ..sort((a, b) => b.datePosted.compareTo(a.datePosted));

    return Scaffold(
      appBar: AppBar(title: const Text('School Announcements')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) =>
            AnnouncementCard(announcement: items[index]),
      ),
    );
  }
}