import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.title,
    required this.content,
    required this.onDelete,
    required this.color,
  });

  final String title;
  final String content;
  final VoidCallback onDelete;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedCurrentDate = DateFormat.yMd().format(currentDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(
                content,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(
                    0,
                    0,
                    0,
                    0.6,
                  ), // Black with 0.6 opacity
                ),
              ),

              trailing: IconButton(
                icon: Icon(Icons.delete, size: 30),
                onPressed: onDelete,
              ),
              iconColor: Colors.black,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 22, right: 25),
              child: Text(
                formattedCurrentDate,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
