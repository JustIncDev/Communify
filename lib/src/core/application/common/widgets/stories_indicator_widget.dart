import 'package:flutter/material.dart';

import '../../../util/assets/colors/colors.dart';

class StoriesProgressIndicatorWidget extends StatelessWidget {
  final int storiesNumber;
  final int currentIndex;

  const StoriesProgressIndicatorWidget({
    required this.storiesNumber,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(storiesNumber, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index != storiesNumber - 1 ? 4 : 0,
                  left: index != 0 ? 4 : 0,
                ),
                child: Container(
                  width: 30,
                  height: 2,
                  decoration: BoxDecoration(
                    color: index < currentIndex
                        ? AppColors.pumpkin.value // Seen story color
                        : Colors.grey, // Unseen story color
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 9),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text('$currentIndex/$storiesNumber'),
        ),
      ],
    );
  }
}
