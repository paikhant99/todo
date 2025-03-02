import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:todo/data/entity/goal.dart';

class GoalItemCard extends StatelessWidget {
  final Goal goal;
  final double percent;
  final Function()? onTap;

  const GoalItemCard({
    super.key,
    required this.goal,
    required this.percent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(goal.goalName,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            subtitle: Text(
                '${goal.completedTasksCount} out of ${goal.allTasksCount} Tasks Completed'),
            leading: SizedBox(
              width: 64,
              height: 64,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  angleRange: 360,
                  startAngle: 180,
                  customWidths: CustomSliderWidths(
                      progressBarWidth: 5,
                      trackWidth: 5,
                      handlerSize: 0,
                      shadowWidth: 0),
                  customColors: CustomSliderColors(
                    progressBarColors: [Colors.blue, Colors.green],
                    trackColor: Colors.grey,
                  ),
                  infoProperties: InfoProperties(
                    mainLabelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: context.textTheme.bodyMedium?.fontSize,
                    ),
                    modifier: (_) {
                      return '$percent' '%';
                    },
                  ),
                ),
                min: 0,
                max: 100,
                initialValue: goal.allTasksCount == 0 ? 0 : percent * 100,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
