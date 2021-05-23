import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key, required this.info}) : super(key: key);
  final Map<String, String> info;

  Widget _buildInfoItem(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              info[title] ?? '',
              textAlign: TextAlign.end,
            ),
          ],
        ),
        if (title != info.keys.last)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 1,
            color: Colors.black26,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: info.keys.map(_buildInfoItem).toList(growable: false),
    );
  }
}
