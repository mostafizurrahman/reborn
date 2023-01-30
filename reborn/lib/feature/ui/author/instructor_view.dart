import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reborn/feature/domain/entities.dart';
import 'package:reborn/feature/ui/widget/profile_view.dart';
import 'package:reborn/utility/app_theme_data.dart';
import 'package:reborn/utility/data_formatter.dart';
import 'package:reborn/utility/screen_data.dart';

class InstructorView extends StatelessWidget {
  final RebornAuthor author;
  final Function(RebornAuthor) onTapAuthor;

  const InstructorView({
    Key? key,
    required this.author,
    required this.onTapAuthor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: screenData.width - 24,
        height: 230,
        child: Container(
          decoration: CCAppTheme.shadowNoBorder.copyWith(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ProfileView(
                  dimension: 75,
                  imagePath: author.profilePicture,
                ),
              ),
              _getInfoRow()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInfoRow() {
    final duration = DataFormatter.formattedDuration(
        Duration(seconds: author.duration.toInt()),
        shouldNewLine: true);
    final loved = DataFormatter.getFormatted(number: author.followers);
    final List<String> summary = [
      duration,
      "|\n|",
      '${author.flagIcon}\n${author.country}',
      "|\n|",
      "$loved\nFollowers"
    ];
    final width = (screenData.width - 37) / 3;
    final List<double> widthList = [width, 2.5, width, 2.5, width];
    final List<Color> colors = [
      Colors.black,
      Colors.pinkAccent,
      Colors.black,
      Colors.pinkAccent,
      Colors.black,
    ];
    final List<FontWeight> weights = [
      FontWeight.bold,
      FontWeight.bold,
      FontWeight.bold,
      FontWeight.bold,
      FontWeight.bold,
    ];

    return Row(
      children: List<Widget>.generate(
        5,
        (index) => SizedBox(
          width: widthList[index],
          child: Center(
            child: Text(
              summary[index],
              textAlign: TextAlign.center,
              style: CCAppTheme.txt.copyWith(
                color: colors[index],
                fontWeight: weights[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
