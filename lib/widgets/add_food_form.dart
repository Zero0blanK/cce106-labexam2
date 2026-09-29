import 'package:flutter/material.dart';

class AddFoodForm extends StatelessWidget {
  const AddFoodForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.isSaving,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final bool isSaving;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLength: 80,
              enabled: !isSaving,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => onSubmit(),
              validator: (value) => value == null || value.trim().isEmpty ? 'Enter a task name' : null,
              decoration: const InputDecoration(
                hintText: 'Add a new task...',
                counterText: '',
                filled: true,
                fillColor: Color(0xFFEFF3F5),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 56,
            width: 56,
            child: FilledButton(
              onPressed: isSaving ? null : onSubmit,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.zero,
              ),
              child: isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2), )
                  : const Icon(Icons.add, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}
