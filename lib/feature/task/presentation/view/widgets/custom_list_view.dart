import 'package:flutter/material.dart';
import 'package:task_app/feature/task/presentation/view/widgets/custom_card_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 17),
            child: CustomCardItem(),
          ),
        ),
      ),
    );
  }
}
