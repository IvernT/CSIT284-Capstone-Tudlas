import 'package:flutter/material.dart';
import '../models/announcement.dart';
import '../services/announcement_service.dart';
import 'announcement_form_screen.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final Announcement announcement;
  final bool isAdmin;
  const AnnouncementDetailScreen({super.key, required this.announcement, this.isAdmin = false});

  Future<void> _confirmDelete(BuildContext context) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete announcement?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (yes == true) {
      await AnnouncementService().delete(announcement.id);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = announcement.datePosted;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement'),
        actions: [
          if (isAdmin) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                final saved = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnnouncementFormScreen(existing: announcement),
                  ),
                );
                // Close detail after editing so the list shows fresh data
                if (saved == true && context.mounted) Navigator.pop(context);
              },
            ),
            IconButton(icon: const Icon(Icons.delete), onPressed: () => _confirmDelete(context)),
          ],
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(announcement.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Posted: ${d.month}/${d.day}/${d.year}', style: Theme.of(context).textTheme.bodySmall),
            const Divider(height: 24),
            Text(announcement.body, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}