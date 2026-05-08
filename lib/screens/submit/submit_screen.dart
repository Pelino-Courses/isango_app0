import 'package:flutter/material.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';
import 'package:isango_app/widgets/isango_bottom_navigation.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _venueController = TextEditingController();
  final _descController = TextEditingController();

  String _category = 'Academic';
  String _campus = 'North Campus';
  DateTime? _date;
  TimeOfDay? _time;

  final _categories = ['Academic', 'Sports', 'Cultural', 'Tech', 'Health', 'Social'];
  final _campuses = ['North Campus', 'Main Campus', 'South Campus'];

  @override
  void dispose() {
    _titleController.dispose();
    _venueController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event submitted for approval!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(title: const Text('Submit Event')),
      bottomNavigationBar: const IsangoBottomNavigation(currentIndex: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Role badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.paleSignalBlue,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: Border.all(color: AppColors.logisticsNavy.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.verified_user_outlined,
                        size: 16, color: AppColors.logisticsNavy),
                    SizedBox(width: AppSpacing.xs),
                    Text(
                      'Logged in as: Club Executive (Approved)',
                      style: TextStyle(
                        color: AppColors.logisticsNavy,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Image upload
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(AppRadii.card),
                    border: Border.all(
                      color: AppColors.mutedOperationalInk.withValues(alpha: 0.4),
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 32, color: AppColors.mutedOperationalInk),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        'Add Image',
                        style: TextStyle(
                          color: AppColors.logisticsNavy,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text('PNG, JPG up to 5MB', style: AppTextStyles.bodyMuted),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Event Title
              _FieldLabel('Event Title'),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'e.g. End of Semester Gala',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Event title is required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              // Category
              _FieldLabel('Category'),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: AppSpacing.md),
              // Campus
              _FieldLabel('Campus'),
              DropdownButtonFormField<String>(
                value: _campus,
                decoration: const InputDecoration(),
                items: _campuses
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _campus = v!),
              ),
              const SizedBox(height: AppSpacing.md),
              // Venue
              _FieldLabel('Venue / Location'),
              TextFormField(
                controller: _venueController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Student Union, Room 302',
                  prefixIcon: Icon(Icons.apartment_outlined),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Venue is required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              // Date
              _FieldLabel('Date'),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _date == null
                          ? 'Select a date'
                          : '${_date!.month}/${_date!.day}/${_date!.year}',
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      suffixIcon: _date == null
                          ? const Icon(Icons.error_outline,
                              color: AppColors.criticalRed)
                          : null,
                    ),
                    validator: (_) =>
                        _date == null ? 'Please select a future date' : null,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Time
              _FieldLabel('Time'),
              GestureDetector(
                onTap: _pickTime,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _time == null
                          ? '--:-- --'
                          : _time!.format(context),
                      prefixIcon: const Icon(Icons.access_time_outlined),
                    ),
                    validator: (_) =>
                        _time == null ? 'Please select a time' : null,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Description
              _FieldLabel('Description'),
              TextFormField(
                controller: _descController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Provide details about what attendees can expect...',
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Description is required' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              // Role info card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.mistBackground,
                  borderRadius: BorderRadius.circular(AppRadii.input),
                  border: Border.all(color: AppColors.softBorder),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline,
                        size: 16, color: AppColors.mutedOperationalInk),
                    SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        'Only approved roles (Staff, Club Execs) can publish. Attendees can browse, save, and RSVP.',
                        style: AppTextStyles.bodyMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send_outlined, size: 18),
                  label: const Text('Submit for Approval'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.logisticsNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                    textStyle: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(text, style: AppTextStyles.title),
    );
  }
}
