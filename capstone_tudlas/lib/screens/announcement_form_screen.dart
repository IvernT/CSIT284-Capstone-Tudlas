import 'package:flutter/material.dart';
import '../models/announcement.dart';
import 'package:capstone_tudlas/services/announcement_service.dart';

class AnnouncementFormScreen extends StatefulWidget {
  final Announcement? existing; // null = creating new
  const AnnouncementFormScreen({super.key, this.existing});

  @override
  State<AnnouncementFormScreen> createState() => _AnnouncementFormScreenState();
}

class _AnnouncementFormScreenState extends State<AnnouncementFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.existing?.title);
  late final _body = TextEditingController(text: widget.existing?.body);
  final _service = AnnouncementService();
  bool _saving = false;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final title = _title.text.trim();
    final body = _body.text.trim();
    if (widget.existing == null) {
      await _service.add(title, body);
    } else {
      await _service.update(widget.existing!.id, title, body);
    }
    if (mounted) Navigator.pop(context, true);
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Announcement' : 'New Announcement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _body,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Message is required' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Saving...' : (editing ? 'Save Changes' : 'Post')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}