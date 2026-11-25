import 'package:capstone_tudlas/screens/announcement_datail_screen.dart';
import 'package:flutter/material.dart';
import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  final bool isAdmin;
  const AnnouncementCard({super.key, required this.announcement, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    final d = announcement.datePosted;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(announcement.title),
        subtitle: Text(announcement.body, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: Text('${d.month}/${d.day}/${d.year}'),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AnnouncementDetailScreen(announcement: announcement, isAdmin: isAdmin),
          ),
        ),
      ),
    );
  }
}