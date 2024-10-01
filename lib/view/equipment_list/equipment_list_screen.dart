import 'package:darlsco/view/equipment_list/equipment_list_screen_mob.dart';

import 'package:darlsco/view/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';

import 'equipment_list_tab.dart';

class EquipmentListScreen extends StatelessWidget {
  const EquipmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const  ResponsiveWidget(mobile:  EquipmentListScreenMob(), tab:  EquipmentListTab());

  }
  
  
  
  }