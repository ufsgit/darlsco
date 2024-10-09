import 'package:darlsco/controller/home/home_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/sample/sample_expiring_equipments.dart';
import 'package:darlsco/view/sample/sample_total_equipments.dart';
import 'package:darlsco/view/sample/sample_total_locations.dart';
import 'package:darlsco/view/sample/sample_upcoming_inspections.dart';
import 'package:darlsco/view/sample/styles/app_colors.dart';
import 'package:darlsco/view/sample/styles/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectionCardWidget extends StatelessWidget {
  const InspectionCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (context) {
        return SizedBox(
          height: 210,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: globalHomeController. contentTextTrainingTab2.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                maxCrossAxisExtent: 190,
                mainAxisExtent: 90),
            itemBuilder: (c, i) => InkWell(
              onTap: () =>Navigator.push(c,CupertinoPageRoute(builder: (c){
                switch (i) {
                  case 0:
                    return const SampleTotalLocations();
        
                  case 1:
                    return const SampleTotalEquipmentsScreen();
                  case 2:
                    return const SampleExpiringEquipments();
                  case 3:
                    return const SampleUpcomingInspections();
                  default:
                    return const SampleTotalLocations();
                }
              })),
              child: Card(
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
                         globalHomeController. contentTextTrainingTab2[i],
                          style: AppStyles.getBodyTextStyle(fontSize: 10),
                        ),
                      ),
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: AppColors.surfaceGrey,
                          child: Text(
                         globalHomeController.numberTextList[i],
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
          ),
        );
      }
    );
  }
}

List<Map<String, dynamic>> inspectionPageCard = [
  {'title': 'Total Locations', 'count': '01'},
  {'title': "Total Equipments", 'count': '02'},
  {'title': "Expiring Equipments", 'count': '03'},
  {'title': 'Upcoming Inspections', 'count': '04'},
];

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}