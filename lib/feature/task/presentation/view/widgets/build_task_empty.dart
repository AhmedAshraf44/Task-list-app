import 'package:flutter/material.dart';

class BuildTaskEmpty extends StatelessWidget {
  const BuildTaskEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 40,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
