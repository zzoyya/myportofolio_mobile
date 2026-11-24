import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';

  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);

    if (!mounted || !loggedIn) return;

    final authState = context.read<AuthState>();
    final token = authState.token;

    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final newProject = Project(
        title: _title,
        description: _description,
        techStack: _techStack,
        projectUrl: _projectUrl,
        projectImageUrl: _projectImageUrl,
      );

      await context.read<ApiClient>().createProject(newProject, token: token);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Project Created!'),
            content: const Text('Your project has been successfully saved.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      Navigator.pop(context);
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 401) {
        await authState.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session expired. Please login again.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create project: HTTP ${e.statusCode}'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String? _validateUrl(String? value, {bool optional = false}) {
    final url = value?.trim() ?? '';

    if (optional && url.isEmpty) return null;

    final uri = Uri.tryParse(url);

    if (uri == null ||
        !uri.hasScheme ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return 'Please enter a valid URL!';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title cannot be empty!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description cannot be empty!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tech Stack',
                  hintText: 'Flutter, Django, Python',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _techStack = value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tech Stack cannot be empty!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Project URL',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectUrl = value,
                validator: (value) => _validateUrl(value),
              ),

              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Project Image URL (Optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) => _validateUrl(value, optional: true),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Save Project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
