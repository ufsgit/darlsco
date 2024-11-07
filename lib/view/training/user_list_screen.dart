import 'package:darlsco/core/constants/color_resources.dart';
import 'package:darlsco/core/constants/common_widgets.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/home/home_controller.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(70.w, 70.h),
          child: commonBackgroundLinearColor(
              childWidget: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
            backgroundColor: ColorResources.colorTransparent,
          ))),
      body: commonBackgroundLinearColorHome(
          childWidget: Container(
        padding: EdgeInsets.all(15.sp),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              GetBuilder<HomeController>(builder: (data) {
                return Get.width > 615
                    ? commonUserListDropdownTab(
                        spacerWidth: 60,
                        context: context,
                        title: 'Current Team Members',
                        dropDownValue: data.currentUserDropDownValue,
                        userList: homeController.isCaliberationSection.value
                            ? data.getCurrentUsersListCaliberation
                            : data.getCurrentUsersList,
                      )
                    : commonUserListDropdown(
                        context: context,
                        title: 'Current Team Members',
                        dropDownValue: data.currentUserDropDownValue,
                        userList: homeController.isCaliberationSection.value
                            ? data.getCurrentUsersListCaliberation
                            : data.getCurrentUsersList,
                      );
              }),
              SizedBox(
                height: 20.h,
              ),

              Get.width > 615
                  ? commonUserListDropdownTab(
                      spacerWidth: 88,
                      isButton: true,
                      context: context,
                      title: 'Other Team Members',
                      dropDownValue: homeController.allUserDropDownValue,
                      userList: homeController.isCaliberationSection.value
                          ? homeController.getAllUsersListCaliberation
                          : homeController.getAllUsersList,
                    )
                  : commonUserListDropdown(
                      isButton: true,
                      context: context,
                      title: 'Other Team Members',
                      dropDownValue: homeController.allUserDropDownValue,
                      userList: homeController.isCaliberationSection.value
                          ? homeController.getAllUsersListCaliberation
                          : homeController.getAllUsersList,
                    ),
              SizedBox(
                height: 20.h,
              ),

              // commonUserListDropdown(),
            ],
          ),
        ),
      )),
    );
  }

  Container updateUserButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.w),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            padding: EdgeInsets.all(4.w),
            onPressed: () {
              if (homeController.allUserDropDownValue.value != '' &&
                  homeController.currentUserDropDownValue.value != '') {
                homeController.changeTaskUser(context);
              } else {
                if (homeController.currentUserDropDownValue.value == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Select the current team member!')));
                } else if (homeController.allUserDropDownValue.value == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Select the member name to be update!')));
                }
              }
            },
            icon: Container(
              width: 80.w,
              height: 40.w,
              decoration: BoxDecoration(
                  color: ColorResources.colorDCCCFF,
                  borderRadius: BorderRadius.circular(10.r)),
              child: const Center(
                child: Text('Update'),
              ),
            )),
      ),
    );
  }

  commonUserListDropdownTab(
      {required String title,
      required BuildContext context,
      isButton = false,
      required double spacerWidth,
      required RxString dropDownValue,
      required List userList}) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: ColorResources.color294C73, fontSize: 18.sp),
              ),
              // SizedBox(
              //   width: spacerWidth.h,
              // ),
              Obx(
                () => SizedBox(
                  width: 500.w,
                  child: DropdownButtonFormField(
                      value: dropDownValue.value == ''
                          ? null
                          : dropDownValue.value,
                      decoration: InputDecoration(
                          hintText:
                              userList.isEmpty ? 'No users Available' : '',
                          border: const OutlineInputBorder()),
                      onChanged: (value) {
                        dropDownValue.value = value.toString();
                      },
                      // hint: Text(''),
                      items: userList
                          .map((e) => DropdownMenuItem(
                                value: e['User_Details_Name'].toString(),
                                child: Text(
                                    "${e['User_Details_Name']}  - ${e['Role_Id'].toString() == '38' ? 'Lead' : 'Staff'}"),
                              ))
                          .toList()),
                ),
              ),
            ],
          ),
          isButton
              ? Align(
                  alignment: Alignment.centerRight,
                  child: updateUserButton(context))
              : Container()
        ],
      ),
    );
  }

  SizedBox commonUserListDropdown(
      {required String title,
      required RxString dropDownValue,
      required BuildContext context,
      isButton = false,
      required List userList}) {
    return SizedBox(
      width: 350.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                TextStyle(color: ColorResources.color294C73, fontSize: 18.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Obx(
            () => SizedBox(
              width: 350.w,
              child: DropdownButtonFormField(
                  value: dropDownValue.value == '' ? null : dropDownValue.value,
                  decoration: InputDecoration(
                      hintText: userList.isEmpty ? 'No users Available' : '',
                      border: const OutlineInputBorder()),
                  onChanged: (value) {
                    dropDownValue.value = value.toString();
                  },
                  // hint: Text(''),
                  items: userList
                      .map((e) => DropdownMenuItem(
                            value: e['User_Details_Name'].toString(),
                            child: Text(
                                '${e['User_Details_Name']} - ${e['Role_Id'].toString() == '38' ? 'Lead' : 'Staff'}'),
                          ))
                      .toList()),
            ),
          ),
          isButton
              ? Align(
                  alignment: Alignment.centerRight,
                  child: updateUserButton(context))
              : Container()
        ],
      ),
    );
  }
}
