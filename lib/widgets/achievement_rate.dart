import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AchievementRate extends StatelessWidget {
  final double percent;
  final int date;

  const AchievementRate({
    required this.percent,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String percentStr = (percent * 100).toStringAsFixed(0);
    final String dateStr = date.toString();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
            color: const Color(0xffF4F4F4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '$percentStr% 달성!',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                      ),
                      Text(
                        (date > 0) ? '$dateStr일 남음' : '만료됨',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: FractionalOffset(percent, 1.0 - percent),
                    child: const FractionallySizedBox(
                      child: Icon(
                        Icons.directions_run,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(10),
                        percent: percent,
                        lineHeight: 10,
                        backgroundColor: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.4),
                        progressColor: Theme.of(context).primaryColor,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
