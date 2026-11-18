import 'package:capstone_tudlas/data/dummy_data.dart';
import 'package:capstone_tudlas/screens/announcement_datail_screen.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    final d = announcement.datePosted;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(announcement.title),
        subtitle: Text(
          announcement.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text('${d.month}/${d.day}/${d.year}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AnnouncementDetailScreen(announcement: announcement),
            ),
          );
        },
      ),
    );
  }
}