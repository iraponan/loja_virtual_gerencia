import 'package:flutter/material.dart';

class AddSizeDialog extends StatelessWidget {
  const AddSizeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Dialog(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    textCapitalization: TextCapitalization.none,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(controller.text.toUpperCase());
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.pinkAccent,
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
