
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/material.dart';

class InspectionCardWidget extends StatelessWidget {
  const InspectionCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: inspectionPageCard.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            maxCrossAxisExtent: 190,
            mainAxisExtent: 90),
        itemBuilder: (c, i) => Card(
          elevation: 0,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    inspectionPageCard[i]['title'],
                    style: AppStyles.getBodyTextStyle(),
                  ),
                ),
                Expanded(
                  child: CircleAvatar(
                    backgroundColor: AppColors.surfaceGrey,
                    child: Text(
                      inspectionPageCard[i]['count'],
                      style: AppStyles.getHeadingTextStyle(
                        fontSize: 12,
                        fontColor: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


List<Map<String, dynamic>> inspectionPageCard = [
  {'title': 'Total Locations', 'count': '01', 'navigate-to': ''},
  {'title': "Total Equipments", 'count': '02', 'navigate-to': ''},
  {'title': "Expiring Equipments", 'count': '03', 'navigate-to': ''},
  {'title': 'Upcoming Inspections', 'count': '04', 'navigate-to': ''},
];
