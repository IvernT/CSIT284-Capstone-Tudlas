import 'package:capstone_tudlas/widgets/announcement_cart.dart';
import 'package:flutter/material.dart';
import '../models/announcement.dart';
import '../services/announcement_service.dart';
import 'announcement_form_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key});

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  final _service = AnnouncementService();
  bool _isAdmin = false;

  Future<void> _toggleAdmin() async {
    if (_isAdmin) {
      setState(() => _isAdmin = false);
      return;
    }
    final controller = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Admin PIN'),
        content: TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text == '1234'),
            child: const Text('Enter'),
          ),
        ],
      ),
    );
    if (ok == true) setState(() => _isAdmin = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Announcements'),
        actions: [
          if (_isAdmin)
            IconButton(
              icon: const Icon(Icons.cloud_upload),
              tooltip: 'Seed sample data',
              onPressed: () => _service.seed(),
            ),
          IconButton(
            icon: Icon(_isAdmin ? Icons.lock_open : Icons.lock),
            tooltip: 'Admin',
            onPressed: _toggleAdmin,
          ),
        ],
      ),
      body: StreamBuilder<List<Announcement>>(
        stream: _service.getAnnouncements(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data!;
          if (items.isEmpty) {
            return const Center(child: Text('No announcements yet.'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) =>
                AnnouncementCard(announcement: items[i], isAdmin: _isAdmin),
          );
        },
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text('Post'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnnouncementFormScreen()),
              ),
            )
          : null,
    );
  }
}