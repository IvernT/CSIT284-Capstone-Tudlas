import 'package:capstone_tudlas/data/dummy_data.dart';
import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementDetailScreen({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final d = announcement.datePosted;
    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(announcement.title,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Posted: ${d.month}/${d.day}/${d.year}',
                style: Theme.of(context).textTheme.bodySmall),
            const Divider(height: 24),
            Text(announcement.body,
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}