import 'package:darlsco/controller/upcoming_inspections/upcoming_inspection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:darlsco/controller/tody_task_controller.dart';
import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/training/widgets/training_widgets.dart';
import 'package:darlsco/view/training_phase2/today_task.dart';
import 'package:darlsco/view/training_phase2/training_attended_page.dart';
import 'package:darlsco/view/training_phase2/upcoming_task.dart';

class TaskPage extends StatefulHookWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

final TodayTaskController todayTaskController = Get.put(TodayTaskController());
final upcomingInspectionsController = Get.put(UpcomingInspectionsController());

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    init();
    super.initState();
  }

  init() async {
    await upcomingInspectionsController.taskInitFunction(context);

    await todayTaskController.fetchTaskCount();
  }

  @override
  Widget build(BuildContext context) {
    final selected = useState<int>(-1);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await init();
          },
          child: commonBackgroundLinearColorTab(
            childWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Obx(() {
                  final taskCounts = todayTaskController.taskPageCount;
                  final countModel =
                      taskCounts.isNotEmpty ? taskCounts[0] : null;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          selected.value = 0;
                          await todayTaskController.fetchTaskCount();
                          Get.to(() => TodayTask(
                                todyasTask: todayTaskController.todayTasksLst,
                              ));
                        },
                        child: taskWidget(
                          text: 'Today\'s Task',
                          number: countModel != null
                              ? countModel.countNow.toString()
                              : '0',
                          color: selected.value == 0
                              ? ColorResources.color8DA0FF.withOpacity(.4)
                              : ColorResources.colorA5A5A5.withOpacity(.2),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () async {
                          // await trainingController.getUpComingTask();
                          selected.value = 1;
                          Get.to(() => const UpcomingTask());
                        },
                        child: taskWidget(
                          text: 'Upcoming Task',
                          number: countModel != null
                              ? countModel.countFuture.toString()
                              : '0',
                          color: selected.value == 1
                              ? ColorResources.color8DA0FF.withOpacity(.4)
                              : ColorResources.colorA5A5A5.withOpacity(.2),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () async {
                          // await todayTaskController.fetchTaskCount();
                          // await trainingController.getTotalTraining();
                          selected.value = 2;
                          Get.to(() => const TotalTrainingAttendedPage());
                        },
                        child: taskWidget(
                          text: 'Total Task Attended',
                          number: countModel != null
                              ? countModel.countPast.toString()
                              : '0',
                          color: selected.value == 2
                              ? ColorResources.color8DA0FF.withOpacity(.4)
                              : ColorResources.colorA5A5A5.withOpacity(.2),
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
