import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_card_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.sizeOf(context).width < 1025 ? 2 : 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          childAspectRatio: 4.7),
      physics: const BouncingScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => const CustomCardItem(),
    );
  }
}
