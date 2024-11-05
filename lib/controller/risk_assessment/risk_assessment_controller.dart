import 'package:darlsco/controller/tainning/trainnig_controller.dart';
import 'package:darlsco/view/home/bottom_navigation_screen.dart';
import 'package:darlsco/view/risk_assessment/risk_assessment_stop_screen.dart';
import 'package:darlsco/view/training/training_inspection_screen.dart';
import 'package:darlsco/view/widgets/loader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../http/http_request.dart';
import '../../http/http_urls.dart';

import '../upcoming_inspections/upcoming_inspection_controller.dart';

final RiskAssessmentController riskAssessmentController =
    Get.put(RiskAssessmentController());

class RiskAssessmentController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool pending = false.obs;
  RxBool completed = false.obs;
  RxBool cancelled = false.obs;
  RxBool hold = false.obs;
  final TextEditingController stopnoteController = TextEditingController();

  // @override
  // void onReady() {
  //   super.onReady();
  //   initFun();
  // }

  initFun() async {
    await listDeclation();
  }

  listDeclation() async {
    riskAssessmentControllerList = [
      [
        [
          physicalNoiseRiskDescriptionController,
          physicalNoiseInitialScoreController,
          // physicalNoiseGoController,

          physicalNoiseFinalScoreController,
          physicalNoiseMitigationController,
          physicalNoiseNogoController,
          // physicalNoiseEquipmentListController,
        ],
        [
          physicalTemperatureRiskDescriptionController,
          physicalTemperatureInitialScoreController,
          // physicalTemperatureGoController,

          physicalTemperatureFinalScoreController,
          physicalTemperatureMitigationController,
          physicalTemperatureNogoController,
          // physicalTemperatureEquipmentListController,
        ],
        [
          physicalRadiationRiskDescriptionController,
          physicalRadiationInitialScoreController,
          // physicalRadiationController,

          physicalRadiationFinalScoreController,
          physicalRadiationMitigationController,
          physicalRadiationNogoController,
          // physicalRadiationEquipmentListController,
        ],
      ],
      [
        [
          safetyFallingRiskDescriptionController,
          safetyFallingInitialScoreController,
          // safetyFallingGoController,
          safetyFallingFinalScoreController,
          safetyFallingMitigationController,

          safetyFallingNogoController,
          // safetyFallingEquipmentListController,
        ],
        [
          safetyTrippingRiskDescriptionController,
          safetyTrippingInitialScoreController,
          // safetyTrippingGoController,
          safetyTrippingFinalScoreController,
          safetyTrippingMitigationController,

          safetyTrippingNogoController,
          // safetyTrippingEquipmentListController,
        ],
        [
          safetyEntanglementRiskDescriptionController,
          safetyEntanglementInitialScoreController,
          // safetyEntanglementGoController,
          safetyEntanglementFinalScoreController,

          safetyEntanglementMitigationController,
          safetyEntanglementNogoController,
          // safetyEntanglementEquipmentListController,
        ],
        [
          safetyCrushingRiskDescriptionController,
          safetyCrushingInitialScoreController,
          // safetyCrushingGoController,

          safetyCrushingFinalScoreController,
          safetyCrushingMitigationController,
          safetyCrushingNogoController,
          // safetyCrushingEquipmentListController,
        ],
        [
          safetyEnvironmentRiskDescriptionController,
          safetyEnvironmentInitialScoreController,
          // safetyEnvironmentGoController,
          safetyEnvironmentFinalScoreController,

          safetyEnvironmentMitigationController,
          safetyEnvironmentNogoController,
          // safetyEnvironmentEquipmentListController,
        ],
        [
          safetyElectricalRiskDescriptionController,
          safetyElectricalInitialScoreController,
          // safetyElectricalGoController,
          safetyElectricalFinalScoreController,

          safetyElectricalMitigationController,
          safetyElectricalNogoController,
          // safetyElectricalEquipmentListController,
        ],
        [
          safetyFaultyRiskDescriptionController,
          safetyFaultyInitialScoreController,
          // safetyFaultyGoController,
          safetyFaultyFinalScoreController,

          safetyFaultyMitigationController,
          safetyFaultyNogoController,
          // safetyFaultyEquipmentListController,
        ],
        [
          safetyConfinedRiskDescriptionController,
          safetyConfinedInitialScoreController,
          // safetyConfinedGoController,
          safetyConfinedFinalScoreController,

          safetyConfinedMitigationController,
          safetyConfinedNogoController,
          // safetyConfinedEquipmentListController,
        ],
        [
          safetyWorkRiskDescriptionController,
          safetyWorkInitialScoreController,
          // safetyWorkGoController,
          safetyWorkFinalScoreController,

          safetyWorkMitigationController,
          safetyWorkNogoController,
          // safetyWorkEquipmentListController,
        ],
      ],
      [
        [
          chemicalCleaningRiskDescriptionController,
          chemicalCleaningInitialScoreController,
          // chemicalCleaningGoController,
          chemicalCleaningFinalScoreController,
          chemicalCleaningMitigationController,

          chemicalCleaningNogoController,
          // chemicalCleaningEquipmentListController,
        ],
        [
          chemicalPesticideRiskDescriptionController,
          chemicalPesticideInitialScoreController,
          // chemicalPesticideGoController,
          chemicalPesticideFinalScoreController,
          chemicalPesticideMitigationController,

          chemicalPesticideNogoController,
          // chemicalPesticideEquipmentListController,
        ],
        [
          chemicalAsbestosRiskDescriptionController,
          chemicalAsbestosInitialScoreController,
          // chemicalAsbestosGoController,
          chemicalAsbestosFinalScoreController,
          chemicalAsbestosMitigationController,

          chemicalAsbestosNogoController,
          // chemicalAsbestosEquipmentListController,
        ],
      ],
      [
        [
          biologicalMoldRiskDescriptionController,
          biologicalMoldInitialScoreController,
          // biologicalMoldGoController,
          biologicalMoldFinalScoreController,
          biologicalMoldMitigationController,

          biologicalMoldNogoController,
          // biologicalMoldEquipmentListController,
        ],
      ],
      [
        [
          erganomicsRepetitionRiskDescriptionController,
          erganomicsRepetitionInitialScoreController,
          // erganomicsRepetitionGoController,
          erganomicsRepetitionFinalScoreController,
          erganomicsRepetitionMitigationController,

          erganomicsRepetitionNogoController,
          // erganomicsRepetitionEquipmentListController,
        ],
        [
          erganomicsLiftingRiskDescriptionController,
          erganomicsLiftingInitialScoreController,
          // erganomicsLiftingGoController,
          erganomicsLiftingFinalScoreController,
          erganomicsLiftingMitigationController,

          erganomicsLiftingNogoController,
          // erganomicsLiftingEquipmentListController,
        ],
        [
          erganomicsAwkwardRiskDescriptionController,
          erganomicsAwkwardInitialScoreController,
          // erganomicsAwkwardGoController,
          erganomicsAwkwardFinalScoreController,
          erganomicsAwkwardMitigationController,

          erganomicsAwkwardNogoController,
          // erganomicsAwkwardEquipmentListController,
        ],
        [
          erganomicsOthersRiskDescriptionController,
          erganomicsOthersInitialScoreController,
          // erganomicsOthersGoController,
          erganomicsOthersFinalScoreController,
          erganomicsOthersMitigationController,

          erganomicsOthersNogoController,
          // erganomicsOthersEquipmentListController,
        ],
      ]
    ];

    // riskAssessmentControllerList = [
    //   [
    //     riskAssessmentController.physicalRiskDescriptionController,
    //     riskAssessmentController.physicalInitialScoreController,
    //     riskAssessmentController.physicalGoController,
    //     riskAssessmentController.physicalMitigationController,
    //     riskAssessmentController.physicalFinalScoreController,
    //     riskAssessmentController.physicalNogoController,
    //     riskAssessmentController.physicalEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.safetyRiskDescriptionController,
    //     riskAssessmentController.safetyInitialScoreController,
    //     riskAssessmentController.safetyGoController,
    //     riskAssessmentController.safetyMitigationController,
    //     riskAssessmentController.safetyFinalScoreController,
    //     riskAssessmentController.safetyNogoController,
    //     riskAssessmentController.safetyEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.chemicalRiskDescriptionController,
    //     riskAssessmentController.chemicalInitialScoreController,
    //     riskAssessmentController.chemicalGoController,
    //     riskAssessmentController.chemicalMitigationController,
    //     riskAssessmentController.chemicalFinalScoreController,
    //     riskAssessmentController.chemicalNogoController,
    //     riskAssessmentController.chemicalEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.cleaningRiskDescriptionController,
    //     riskAssessmentController.cleaningInitialScoreController,
    //     riskAssessmentController.cleaningGoController,
    //     riskAssessmentController.cleaningMitigationController,
    //     riskAssessmentController.cleaningFinalScoreController,
    //     riskAssessmentController.cleaningNogoController,
    //     riskAssessmentController.cleaningEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.pesticideRiskDescriptionController,
    //     riskAssessmentController.pesticideInitialScoreController,
    //     riskAssessmentController.pesticideGoController,
    //     riskAssessmentController.pesticideMitigationController,
    //     riskAssessmentController.pesticideFinalScoreController,
    //     riskAssessmentController.pesticideNogoController,
    //     riskAssessmentController.pesticideEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.asbestosRiskDescriptionController,
    //     riskAssessmentController.asbestosInitialScoreController,
    //     riskAssessmentController.asbestosGoController,
    //     riskAssessmentController.asbestosMitigationController,
    //     riskAssessmentController.asbestosFinalScoreController,
    //     riskAssessmentController.asbestosNogoController,
    //     riskAssessmentController.asbestosEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.biologicalRiskDescriptionController,
    //     riskAssessmentController.biologicalInitialScoreController,
    //     riskAssessmentController.biologicalGoController,
    //     riskAssessmentController.biologicalMitigationController,
    //     riskAssessmentController.biologicalFinalScoreController,
    //     riskAssessmentController.biologicalNogoController,
    //     riskAssessmentController.biologicalEquipmentListController,
    //   ],
    //   [
    //     riskAssessmentController.economicsRiskDescriptionController,
    //     riskAssessmentController.economicsInitialScoreController,
    //     riskAssessmentController.economicsGoController,
    //     riskAssessmentController.economicsMitigationController,
    //     riskAssessmentController.economicsFinalScoreController,
    //     riskAssessmentController.economicsNogoController,
    //     riskAssessmentController.economicsEquipmentListController,
    //   ]
    // ];
  }

  List<String> assessmentList = [
    'Physical Hazard',
    'Safety Hazard',
    'Chemical Hazard',
    'Biological Hazard',
    'Ergonomics Hazard'
  ];

  List subAssessmentLIst = [
    ['Noise', 'Temperature', 'Radiation'],
    [
      'Falling',
      'Tripping',
      'Entanglement',
      'Crushing',
      'Environment',
      'Electrical',
      'Faulty Equipment',
      'Confined Space',
      'Work at height',
    ],
    ['Cleaning Products', 'Pesticide', 'Asbestos'],
    ['Mold, Insect, pest'],
    ['Repetition', 'Lifting', 'Awkward Postures', 'Others'],
  ];

  List<String> textFieldTitles = [
    'Risk Description',
    'Initial Score',
    'Final Score',
    // 'Go',
    'Mitigation Measure',

    'Go/No Go',
    // 'Equipment List',
  ];

  List<TextInputType?> textfieldKeyboardType = [
    null,
    TextInputType.number,
    TextInputType.number,
    // 'Go',
    null,

    null,
    // 'Equipment List',
  ];

  List<int> textfieldMaxLength = [
    250,
    25,
    // 'Go',
    25,
    50,
    50,
    // 'Equipment List',
  ];
  //physical hazard section
  //noises

  final TextEditingController physicalNoiseRiskDescriptionController =
      TextEditingController();
  TextEditingController physicalNoiseInitialScoreController =
      TextEditingController();
  // TextEditingController physicalNoiseGoController = TextEditingController();
  TextEditingController physicalNoiseMitigationController =
      TextEditingController();
  TextEditingController physicalNoiseFinalScoreController =
      TextEditingController();
  TextEditingController physicalNoiseNogoController = TextEditingController();
  // TextEditingController physicalNoiseEquipmentListController =
  //     TextEditingController();
//temperature
  TextEditingController physicalTemperatureRiskDescriptionController =
      TextEditingController();
  TextEditingController physicalTemperatureInitialScoreController =
      TextEditingController();
  // TextEditingController physicalTemperatureGoController =
  //     TextEditingController();
  TextEditingController physicalTemperatureMitigationController =
      TextEditingController();
  TextEditingController physicalTemperatureFinalScoreController =
      TextEditingController();
  TextEditingController physicalTemperatureNogoController =
      TextEditingController();
  // TextEditingController physicalTemperatureEquipmentListController =
  //     TextEditingController();

//Radiation
  TextEditingController physicalRadiationRiskDescriptionController =
      TextEditingController();
  TextEditingController physicalRadiationInitialScoreController =
      TextEditingController();
  // TextEditingController physicalRadiationController = TextEditingController();
  TextEditingController physicalRadiationMitigationController =
      TextEditingController();
  TextEditingController physicalRadiationFinalScoreController =
      TextEditingController();
  TextEditingController physicalRadiationNogoController =
      TextEditingController();
  // TextEditingController physicalRadiationEquipmentListController =
  //     TextEditingController();

//Safety Hazard
//Falling

  TextEditingController safetyFallingRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyFallingInitialScoreController =
      TextEditingController();
  // TextEditingController safetyFallingGoController = TextEditingController();
  TextEditingController safetyFallingMitigationController =
      TextEditingController();
  TextEditingController safetyFallingFinalScoreController =
      TextEditingController();
  TextEditingController safetyFallingNogoController = TextEditingController();
  // TextEditingController safetyFallingEquipmentListController =
  //     TextEditingController();

//Tripping

  TextEditingController safetyTrippingRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyTrippingInitialScoreController =
      TextEditingController();
  // TextEditingController safetyTrippingGoController = TextEditingController();
  TextEditingController safetyTrippingMitigationController =
      TextEditingController();
  TextEditingController safetyTrippingFinalScoreController =
      TextEditingController();
  TextEditingController safetyTrippingNogoController = TextEditingController();
  // TextEditingController safetyTrippingEquipmentListController =
  //     TextEditingController();
//Entanglement
  TextEditingController safetyEntanglementRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyEntanglementInitialScoreController =
      TextEditingController();
  // TextEditingController safetyEntanglementGoController =
  //     TextEditingController();
  TextEditingController safetyEntanglementMitigationController =
      TextEditingController();
  TextEditingController safetyEntanglementFinalScoreController =
      TextEditingController();
  TextEditingController safetyEntanglementNogoController =
      TextEditingController();
  // TextEditingController safetyEntanglementEquipmentListController =
  //     TextEditingController();
//Crushing
  TextEditingController safetyCrushingRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyCrushingInitialScoreController =
      TextEditingController();
  // TextEditingController safetyCrushingGoController = TextEditingController();
  TextEditingController safetyCrushingMitigationController =
      TextEditingController();
  TextEditingController safetyCrushingFinalScoreController =
      TextEditingController();
  TextEditingController safetyCrushingNogoController = TextEditingController();
  // TextEditingController safetyCrushingEquipmentListController =
  //     TextEditingController();
//Environment
  TextEditingController safetyEnvironmentRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyEnvironmentInitialScoreController =
      TextEditingController();
  // TextEditingController safetyEnvironmentGoController = TextEditingController();
  TextEditingController safetyEnvironmentMitigationController =
      TextEditingController();
  TextEditingController safetyEnvironmentFinalScoreController =
      TextEditingController();
  TextEditingController safetyEnvironmentNogoController =
      TextEditingController();
  // TextEditingController safetyEnvironmentEquipmentListController =
  //     TextEditingController();
//Electrical
  TextEditingController safetyElectricalRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyElectricalInitialScoreController =
      TextEditingController();
  // TextEditingController safetyElectricalGoController = TextEditingController();
  TextEditingController safetyElectricalMitigationController =
      TextEditingController();
  TextEditingController safetyElectricalFinalScoreController =
      TextEditingController();
  TextEditingController safetyElectricalNogoController =
      TextEditingController();
  // TextEditingController safetyElectricalEquipmentListController =
  //     TextEditingController();
//Faulty Equipment
  TextEditingController safetyFaultyRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyFaultyInitialScoreController =
      TextEditingController();
  // TextEditingController safetyFaultyGoController = TextEditingController();
  TextEditingController safetyFaultyMitigationController =
      TextEditingController();
  TextEditingController safetyFaultyFinalScoreController =
      TextEditingController();
  TextEditingController safetyFaultyNogoController = TextEditingController();
  // TextEditingController safetyFaultyEquipmentListController =
  //     TextEditingController();

//Confined Space
  TextEditingController safetyConfinedRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyConfinedInitialScoreController =
      TextEditingController();
  // TextEditingController safetyConfinedGoController = TextEditingController();
  TextEditingController safetyConfinedMitigationController =
      TextEditingController();
  TextEditingController safetyConfinedFinalScoreController =
      TextEditingController();
  TextEditingController safetyConfinedNogoController = TextEditingController();
  // TextEditingController safetyConfinedEquipmentListController =
  //     TextEditingController();
  //Work at height
  TextEditingController safetyWorkRiskDescriptionController =
      TextEditingController();
  TextEditingController safetyWorkInitialScoreController =
      TextEditingController();
  // TextEditingController safetyWorkGoController = TextEditingController();
  TextEditingController safetyWorkMitigationController =
      TextEditingController();
  TextEditingController safetyWorkFinalScoreController =
      TextEditingController();
  TextEditingController safetyWorkNogoController = TextEditingController();
  // TextEditingController safetyWorkEquipmentListController =
  //     TextEditingController();

//chemical section
//Cleaning Hazard

  TextEditingController chemicalCleaningRiskDescriptionController =
      TextEditingController();
  TextEditingController chemicalCleaningInitialScoreController =
      TextEditingController();
  // TextEditingController chemicalCleaningGoController = TextEditingController();
  TextEditingController chemicalCleaningMitigationController =
      TextEditingController();
  TextEditingController chemicalCleaningFinalScoreController =
      TextEditingController();
  TextEditingController chemicalCleaningNogoController =
      TextEditingController();
  // TextEditingController chemicalCleaningEquipmentListController =
  //     TextEditingController();

//Pesticide

  TextEditingController chemicalPesticideRiskDescriptionController =
      TextEditingController();
  TextEditingController chemicalPesticideInitialScoreController =
      TextEditingController();
  // TextEditingController chemicalPesticideGoController = TextEditingController();
  TextEditingController chemicalPesticideMitigationController =
      TextEditingController();
  TextEditingController chemicalPesticideFinalScoreController =
      TextEditingController();
  TextEditingController chemicalPesticideNogoController =
      TextEditingController();
  // TextEditingController chemicalPesticideEquipmentListController =
  //     TextEditingController();

//Asbestos

  TextEditingController chemicalAsbestosRiskDescriptionController =
      TextEditingController();
  TextEditingController chemicalAsbestosInitialScoreController =
      TextEditingController();
  // TextEditingController chemicalAsbestosGoController = TextEditingController();
  TextEditingController chemicalAsbestosMitigationController =
      TextEditingController();
  TextEditingController chemicalAsbestosFinalScoreController =
      TextEditingController();
  TextEditingController chemicalAsbestosNogoController =
      TextEditingController();
  // TextEditingController chemicalAsbestosEquipmentListController =
  //     TextEditingController();

//Biological Hazard
//Mold

  TextEditingController biologicalMoldRiskDescriptionController =
      TextEditingController();
  TextEditingController biologicalMoldInitialScoreController =
      TextEditingController();
  // TextEditingController biologicalMoldGoController = TextEditingController();
  TextEditingController biologicalMoldMitigationController =
      TextEditingController();
  TextEditingController biologicalMoldFinalScoreController =
      TextEditingController();
  TextEditingController biologicalMoldNogoController = TextEditingController();
  // TextEditingController biologicalMoldEquipmentListController =
  //     TextEditingController();

  //

  //Ergonomics Hazard
  //Repetition

  TextEditingController erganomicsRepetitionRiskDescriptionController =
      TextEditingController();
  TextEditingController erganomicsRepetitionInitialScoreController =
      TextEditingController();
  // TextEditingController erganomicsRepetitionGoController =
  //     TextEditingController();
  TextEditingController erganomicsRepetitionMitigationController =
      TextEditingController();
  TextEditingController erganomicsRepetitionFinalScoreController =
      TextEditingController();
  TextEditingController erganomicsRepetitionNogoController =
      TextEditingController();
  // TextEditingController erganomicsRepetitionEquipmentListController =
  //     TextEditingController();
  //Lifting

  TextEditingController erganomicsLiftingRiskDescriptionController =
      TextEditingController();
  TextEditingController erganomicsLiftingInitialScoreController =
      TextEditingController();
  // TextEditingController erganomicsLiftingGoController = TextEditingController();
  TextEditingController erganomicsLiftingMitigationController =
      TextEditingController();
  TextEditingController erganomicsLiftingFinalScoreController =
      TextEditingController();
  TextEditingController erganomicsLiftingNogoController =
      TextEditingController();
  // TextEditingController erganomicsLiftingEquipmentListController =
  //     TextEditingController();

  //Awkward Postures

  TextEditingController erganomicsAwkwardRiskDescriptionController =
      TextEditingController();
  TextEditingController erganomicsAwkwardInitialScoreController =
      TextEditingController();
  // TextEditingController erganomicsAwkwardGoController = TextEditingController();
  TextEditingController erganomicsAwkwardMitigationController =
      TextEditingController();
  TextEditingController erganomicsAwkwardFinalScoreController =
      TextEditingController();
  TextEditingController erganomicsAwkwardNogoController =
      TextEditingController();
  // TextEditingController erganomicsAwkwardEquipmentListController =
  //     TextEditingController();
  //Others

  TextEditingController erganomicsOthersRiskDescriptionController =
      TextEditingController();
  TextEditingController erganomicsOthersInitialScoreController =
      TextEditingController();
  // TextEditingController erganomicsOthersGoController = TextEditingController();
  TextEditingController erganomicsOthersMitigationController =
      TextEditingController();
  TextEditingController erganomicsOthersFinalScoreController =
      TextEditingController();
  TextEditingController erganomicsOthersNogoController =
      TextEditingController();
  // TextEditingController erganomicsOthersEquipmentListController =
  //     TextEditingController();

  List riskAssessmentControllerList = [];

  saveTaskRiskAssistantsPhysicalHazard() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    // Map<String, dynamic> sendSaveTaskRiskTestData = {
    //   "Task_Id_": int.parse(upcomingInspectionsController.taskDetailsData[0]
    //           ['Task_Id']
    //       .toString()),
    //   "User_Details_Id_": int.parse(upcomingInspectionsController
    //       .taskUserDetails[0]['Task_User_Details_Id']
    //       .toString()),
    //   "physical_hazard_": {
    //     "noise": {
    //       "risk_description": physicalNoiseRiskDescriptionController.text,
    //       "initial_score": physicalNoiseInitialScoreController.text,
    //       "go": physicalNoiseGoController.text,
    //       'mitigation_measure': physicalNoiseMitigationController.text,
    //       'final_score': physicalNoiseFinalScoreController.text,
    //       'no_go': physicalNoiseNogoController.text,
    //       'equipment_list': physicalNoiseEquipmentListController.text,
    //     },
    //     'temperature': {
    //       "risk_description": physicalTemperatureRiskDescriptionController.text,
    //       "initial_score": physicalTemperatureInitialScoreController.text,
    //       "go": physicalTemperatureGoController.text,
    //       'mitigation_measure': physicalTemperatureMitigationController.text,
    //       'final_score': physicalTemperatureFinalScoreController.text,
    //       'no_go': physicalTemperatureNogoController.text,
    //       'equipment_list': physicalTemperatureEquipmentListController.text,
    //     },
    //     'radiation': {
    //       "risk_description": physicalRadiationRiskDescriptionController.text,
    //       "initial_score": physicalRadiationInitialScoreController.text,
    //       "go": physicalRadiationController.text,
    //       'mitigation_measure': physicalRadiationMitigationController.text,
    //       'final_score': physicalRadiationFinalScoreController.text,
    //       'no_go': physicalRadiationNogoController.text,
    //       'equipment_list': physicalRadiationEquipmentListController.text,
    //     }
    //   },
    // };

    await HttpRequest.httpPostRequest(
      bodyData: {'sendSaveTaskRiskTestData': ''},
      endPoint: HttpUrls.saveTaskRiskAssistantsPhysicalHazard,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          clearValues();
          // Get.to(() => RiskAssessmentScreen());
        }
      }
    });
  }

  getPostDataRiskSection1() {
    Map<String, dynamic> sendSaveTaskRiskTestPostData = {
      'Task_Id_': int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      'User_Details_Id_': int.parse(upcomingInspectionsController
          .taskUserDetails[0]['User_Details_Id']
          .toString()),
      'datas': {
        'is_physical_hazard_completed':
            riskAssessmentController.isPhysicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 1
                : 0,
        'is_safty_hazard_completed':
            riskAssessmentController.isSaftyCheckTextBoxFill() == 'fullyFilled'
                ? 0
                : 0,
        'is_chemical_hazard_completed':
            riskAssessmentController.isChemicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_biological_hazard_completed':
            riskAssessmentController.isBiologicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_erganomics_hazard_completed':
            riskAssessmentController.isErganomicCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
      },
      "physical_hazard_": [
        {
          "Physical_Hazard_Name": "noise",
          "risk_description": riskAssessmentController
              .physicalNoiseRiskDescriptionController.text,
          "initial_score":
              riskAssessmentController.physicalNoiseInitialScoreController.text,
          // "go": riskAssessmentController.physicalNoiseGoController.text,
          'mitigation_measure':
              riskAssessmentController.physicalNoiseMitigationController.text,
          'final_score':
              riskAssessmentController.physicalNoiseFinalScoreController.text,
          'no_go': riskAssessmentController.physicalNoiseNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .physicalNoiseEquipmentListController.text,
        },
        {
          "Physical_Hazard_Name": "temperature",
          "risk_description": riskAssessmentController
              .physicalTemperatureRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .physicalTemperatureInitialScoreController.text,
          // "go": riskAssessmentController.physicalTemperatureGoController.text,
          'mitigation_measure': riskAssessmentController
              .physicalTemperatureMitigationController.text,
          'final_score': riskAssessmentController
              .physicalTemperatureFinalScoreController.text,
          'no_go':
              riskAssessmentController.physicalTemperatureNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .physicalTemperatureEquipmentListController.text,
        },
        {
          "Physical_Hazard_Name": "radiation",
          "risk_description": riskAssessmentController
              .physicalRadiationRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .physicalRadiationInitialScoreController.text,
          // "go": riskAssessmentController.physicalRadiationController.text,
          'mitigation_measure': riskAssessmentController
              .physicalRadiationMitigationController.text,
          'final_score': riskAssessmentController
              .physicalRadiationFinalScoreController.text,
          'no_go':
              riskAssessmentController.physicalRadiationNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .physicalRadiationEquipmentListController.text,
        },
      ],
    };

    return sendSaveTaskRiskTestPostData;
  }

  getPostDataRiskSection3() {
    Map<String, dynamic> sendSaveTaskRiskTestPostData = {
      'Task_Id_': int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      'User_Details_Id_': int.parse(upcomingInspectionsController
          .taskUserDetails[0]['User_Details_Id']
          .toString()),
      'datas': {
        'is_physical_hazard_completed':
            riskAssessmentController.isPhysicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_safty_hazard_completed':
            riskAssessmentController.isSaftyCheckTextBoxFill() == 'fullyFilled'
                ? 1
                : 0,
        'is_chemical_hazard_completed':
            riskAssessmentController.isChemicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 1
                : 0,
        'is_biological_hazard_completed':
            riskAssessmentController.isBiologicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_erganomics_hazard_completed':
            riskAssessmentController.isErganomicCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
      },
      "safety_hazard_": [
        {
          "Safty_Hazard_Name": "falling",
          "risk_description": riskAssessmentController
              .safetyFallingRiskDescriptionController.text,
          "initial_score":
              riskAssessmentController.safetyFallingInitialScoreController.text,
          // "go": riskAssessmentController.safetyFallingGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyFallingMitigationController.text,
          'final_score':
              riskAssessmentController.safetyFallingFinalScoreController.text,
          'no_go': riskAssessmentController.safetyFallingNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyFallingEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "tripping",
          "risk_description": riskAssessmentController
              .safetyTrippingRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyTrippingInitialScoreController.text,
          // "go": riskAssessmentController.safetyTrippingGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyTrippingMitigationController.text,
          'final_score':
              riskAssessmentController.safetyTrippingFinalScoreController.text,
          'no_go': riskAssessmentController.safetyTrippingNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyTrippingEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "entanglement",
          "risk_description": riskAssessmentController
              .safetyEntanglementRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyEntanglementInitialScoreController.text,
          // "go": riskAssessmentController.safetyEntanglementGoController.text,
          'mitigation_measure': riskAssessmentController
              .safetyEntanglementMitigationController.text,
          'final_score': riskAssessmentController
              .safetyEntanglementFinalScoreController.text,
          'no_go':
              riskAssessmentController.safetyEntanglementNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyEntanglementEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "crushing",
          "risk_description": riskAssessmentController
              .safetyCrushingRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyCrushingInitialScoreController.text,
          // "go": riskAssessmentController.safetyCrushingGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyCrushingMitigationController.text,
          'final_score':
              riskAssessmentController.safetyCrushingFinalScoreController.text,
          'no_go': riskAssessmentController.safetyCrushingNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyCrushingEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "environment",
          "risk_description": riskAssessmentController
              .safetyEnvironmentRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyEnvironmentInitialScoreController.text,
          // "go": riskAssessmentController.safetyEnvironmentGoController.text,
          'mitigation_measure': riskAssessmentController
              .safetyEnvironmentMitigationController.text,
          'final_score': riskAssessmentController
              .safetyEnvironmentFinalScoreController.text,
          'no_go':
              riskAssessmentController.safetyEnvironmentNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyEnvironmentEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "electrical",
          "risk_description": riskAssessmentController
              .safetyElectricalRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyElectricalInitialScoreController.text,
          // "go": riskAssessmentController.safetyElectricalGoController.text,
          'mitigation_measure': riskAssessmentController
              .safetyElectricalMitigationController.text,
          'final_score': riskAssessmentController
              .safetyElectricalFinalScoreController.text,
          'no_go': riskAssessmentController.safetyElectricalNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyElectricalEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "faulty_equipment",
          "risk_description": riskAssessmentController
              .safetyFaultyRiskDescriptionController.text,
          "initial_score":
              riskAssessmentController.safetyFaultyInitialScoreController.text,
          // "go": riskAssessmentController.safetyFaultyGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyFaultyMitigationController.text,
          'final_score':
              riskAssessmentController.safetyFaultyFinalScoreController.text,
          'no_go': riskAssessmentController.safetyFaultyNogoController.text,
          // 'equipment_list':
          //     riskAssessmentController.safetyFaultyEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "confined_pace",
          "risk_description": riskAssessmentController
              .safetyConfinedRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .safetyConfinedInitialScoreController.text,
          // "go": riskAssessmentController.safetyConfinedGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyConfinedMitigationController.text,
          'final_score':
              riskAssessmentController.safetyConfinedFinalScoreController.text,
          'no_go': riskAssessmentController.safetyConfinedNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .safetyConfinedEquipmentListController.text,
        },
        {
          "Safty_Hazard_Name": "work_at_height",
          "risk_description":
              riskAssessmentController.safetyWorkRiskDescriptionController.text,
          "initial_score":
              riskAssessmentController.safetyWorkInitialScoreController.text,
          // "go": riskAssessmentController.safetyWorkGoController.text,
          'mitigation_measure':
              riskAssessmentController.safetyWorkMitigationController.text,
          'final_score':
              riskAssessmentController.safetyWorkFinalScoreController.text,
          'no_go': riskAssessmentController.safetyWorkNogoController.text,
          // 'equipment_list':
          //     riskAssessmentController.safetyWorkEquipmentListController.text,
        },
      ],
      "chemical_hazard_": [
        {
          "Chemical_Hazard_Name": "work_at_height",
          "risk_description": riskAssessmentController
              .chemicalCleaningRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .chemicalCleaningInitialScoreController.text,
          // "go": riskAssessmentController.chemicalCleaningGoController.text,
          'mitigation_measure': riskAssessmentController
              .chemicalCleaningMitigationController.text,
          'final_score': riskAssessmentController
              .chemicalCleaningFinalScoreController.text,
          'no_go': riskAssessmentController.chemicalCleaningNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .chemicalCleaningEquipmentListController.text,
        },
        {
          "Chemical_Hazard_Name": "pesticide",
          "risk_description": riskAssessmentController
              .chemicalPesticideRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .chemicalPesticideInitialScoreController.text,
          // "go": riskAssessmentController.chemicalPesticideGoController.text,
          'mitigation_measure': riskAssessmentController
              .chemicalPesticideMitigationController.text,
          'final_score': riskAssessmentController
              .chemicalPesticideFinalScoreController.text,
          'no_go':
              riskAssessmentController.chemicalPesticideNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .chemicalPesticideEquipmentListController.text,
        },
        {
          "Chemical_Hazard_Name": "asbestos",
          "risk_description": riskAssessmentController
              .chemicalAsbestosRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .chemicalAsbestosInitialScoreController.text,
          // "go": riskAssessmentController.chemicalAsbestosGoController.text,
          'mitigation_measure': riskAssessmentController
              .chemicalAsbestosMitigationController.text,
          'final_score': riskAssessmentController
              .chemicalAsbestosFinalScoreController.text,
          'no_go': riskAssessmentController.chemicalAsbestosNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .chemicalAsbestosEquipmentListController.text,
        },
      ],
    };

    return sendSaveTaskRiskTestPostData;
  }

  getPostDataRiskSection2() {
    Map<String, dynamic> sendTaskRiskTestPostData2 = {
      'Task_Id_': int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      'User_Details_Id_': int.parse(upcomingInspectionsController
          .taskUserDetails[0]['User_Details_Id']
          .toString()),
      'datas': {
        'is_physical_hazard_completed':
            riskAssessmentController.isPhysicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_safty_hazard_completed':
            riskAssessmentController.isSaftyCheckTextBoxFill() == 'fullyFilled'
                ? 0
                : 0,
        'is_chemical_hazard_completed':
            riskAssessmentController.isChemicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 0
                : 0,
        'is_biological_hazard_completed':
            riskAssessmentController.isBiologicalCheckTextBoxFill() ==
                    'fullyFilled'
                ? 1
                : 0,
        'is_erganomics_hazard_completed':
            riskAssessmentController.isErganomicCheckTextBoxFill() ==
                    'fullyFilled'
                ? 1
                : 0,
      },
      "biological_hazard_": [
        {
          "Biological_Hazard_Name": "mold",
          "risk_description": riskAssessmentController
              .biologicalMoldRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .biologicalMoldInitialScoreController.text,
          // "go": riskAssessmentController.biologicalMoldGoController.text,
          'mitigation_measure':
              riskAssessmentController.biologicalMoldMitigationController.text,
          'final_score':
              riskAssessmentController.biologicalMoldFinalScoreController.text,
          'no_go': riskAssessmentController.biologicalMoldNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .biologicalMoldEquipmentListController.text,
        },
      ],
      "ergonomics_hazard_": [
        {
          "Erganomics_Hazard_Name": "repetition",
          "risk_description": riskAssessmentController
              .erganomicsRepetitionRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .erganomicsRepetitionInitialScoreController.text,
          // "go": riskAssessmentController.erganomicsRepetitionGoController.text,
          'mitigation_measure': riskAssessmentController
              .erganomicsRepetitionMitigationController.text,
          'final_score': riskAssessmentController
              .erganomicsRepetitionFinalScoreController.text,
          'no_go':
              riskAssessmentController.erganomicsRepetitionNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .erganomicsRepetitionEquipmentListController.text,
        },
        {
          "Erganomics_Hazard_Name": "lifting",
          "risk_description": riskAssessmentController
              .erganomicsLiftingRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .erganomicsLiftingInitialScoreController.text,
          // "go": riskAssessmentController.erganomicsLiftingGoController.text,
          'mitigation_measure': riskAssessmentController
              .erganomicsLiftingMitigationController.text,
          'final_score': riskAssessmentController
              .erganomicsLiftingFinalScoreController.text,
          'no_go':
              riskAssessmentController.erganomicsLiftingNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .erganomicsLiftingEquipmentListController.text,
        },
        {
          "Erganomics_Hazard_Name": "awkward_postures",
          "risk_description": riskAssessmentController
              .erganomicsAwkwardRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .erganomicsAwkwardInitialScoreController.text,
          // "go": riskAssessmentController.erganomicsAwkwardGoController.text,
          'mitigation_measure': riskAssessmentController
              .erganomicsAwkwardMitigationController.text,
          'final_score': riskAssessmentController
              .erganomicsAwkwardFinalScoreController.text,
          'no_go':
              riskAssessmentController.erganomicsAwkwardNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .erganomicsAwkwardEquipmentListController.text,
        },
        {
          "Erganomics_Hazard_Name": "others",
          "risk_description": riskAssessmentController
              .erganomicsOthersRiskDescriptionController.text,
          "initial_score": riskAssessmentController
              .erganomicsOthersInitialScoreController.text,
          // "go": riskAssessmentController.erganomicsOthersGoController.text,
          'mitigation_measure': riskAssessmentController
              .erganomicsOthersMitigationController.text,
          'final_score': riskAssessmentController
              .erganomicsOthersFinalScoreController.text,
          'no_go': riskAssessmentController.erganomicsOthersNogoController.text,
          // 'equipment_list': riskAssessmentController
          //     .erganomicsOthersEquipmentListController.text,
        },
      ],
    };

    return sendTaskRiskTestPostData2;
  }

  saveTaskRiskAssistantsSafetyHzard() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> sendSaveTaskRiskTestData = {
      "Task_Id_": int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      "User_Details_Id_": int.parse(upcomingInspectionsController
          .taskUserDetails[0]['Task_User_Details_Id']
          .toString()),
      "safety_hazard_": {
        'falling': {
          "risk_description": safetyFallingRiskDescriptionController.text,
          "initial_score": safetyFallingInitialScoreController.text,
          // "go": safetyFallingGoController.text,
          'mitigation_measure': safetyFallingMitigationController.text,
          'final_score': safetyFallingFinalScoreController.text,
          'no_go': safetyFallingNogoController.text,
          // 'equipment_list': safetyFallingEquipmentListController.text,
        },
        'tripping': {
          "risk_description": safetyTrippingRiskDescriptionController.text,
          "initial_score": safetyTrippingInitialScoreController.text,
          // "go": safetyTrippingGoController.text,
          'mitigation_measure': safetyTrippingMitigationController.text,
          'final_score': safetyTrippingFinalScoreController.text,
          'no_go': safetyTrippingNogoController.text,
          // 'equipment_list': safetyTrippingEquipmentListController.text,
        },
        'entanglement': {
          "risk_description": safetyEntanglementRiskDescriptionController.text,
          "initial_score": safetyEntanglementInitialScoreController.text,
          // "go": safetyEntanglementGoController.text,
          'mitigation_measure': safetyEntanglementMitigationController.text,
          'final_score': safetyEntanglementFinalScoreController.text,
          'no_go': safetyEntanglementNogoController.text,
          // 'equipment_list': safetyEntanglementEquipmentListController.text,
        },
        'crushing': {
          "risk_description": safetyCrushingRiskDescriptionController.text,
          "initial_score": safetyCrushingInitialScoreController.text,
          // "go": safetyCrushingGoController.text,
          'mitigation_measure': safetyCrushingMitigationController.text,
          'final_score': safetyCrushingFinalScoreController.text,
          'no_go': safetyCrushingNogoController.text,
          // 'equipment_list': safetyCrushingEquipmentListController.text,
        },
        'environment': {
          "risk_description": safetyEnvironmentRiskDescriptionController.text,
          "initial_score": safetyEnvironmentInitialScoreController.text,
          // "go": safetyEnvironmentGoController.text,
          'mitigation_measure': safetyEnvironmentMitigationController.text,
          'final_score': safetyEnvironmentFinalScoreController.text,
          'no_go': safetyEnvironmentNogoController.text,
          // 'equipment_list': safetyEnvironmentEquipmentListController.text,
        },
        'electrical': {
          "risk_description": safetyElectricalRiskDescriptionController.text,
          "initial_score": safetyElectricalInitialScoreController.text,
          // "go": safetyElectricalGoController.text,
          'mitigation_measure': safetyElectricalMitigationController.text,
          'final_score': safetyElectricalFinalScoreController.text,
          'no_go': safetyElectricalNogoController.text,
          // 'equipment_list': safetyElectricalEquipmentListController.text,
        },
        'faulty_equipment': {
          "risk_description": safetyFaultyRiskDescriptionController.text,
          "initial_score": safetyFaultyInitialScoreController.text,
          // "go": safetyFaultyGoController.text,
          'mitigation_measure': safetyFaultyMitigationController.text,
          'final_score': safetyFaultyFinalScoreController.text,
          'no_go': safetyFaultyNogoController.text,
          // 'equipment_list': safetyFaultyEquipmentListController.text,
        },
        'confined_pace': {
          "risk_description": safetyConfinedRiskDescriptionController.text,
          "initial_score": safetyConfinedInitialScoreController.text,
          // "go": safetyConfinedGoController.text,
          'mitigation_measure': safetyConfinedMitigationController.text,
          'final_score': safetyConfinedFinalScoreController.text,
          'no_go': safetyConfinedNogoController.text,
          // 'equipment_list': safetyConfinedEquipmentListController.text,
        },
        'work_at_height': {
          "risk_description": safetyWorkRiskDescriptionController.text,
          "initial_score": safetyWorkInitialScoreController.text,
          // "go": safetyWorkGoController.text,
          'mitigation_measure': safetyWorkMitigationController.text,
          'final_score': safetyWorkFinalScoreController.text,
          'no_go': safetyWorkNogoController.text,
          // 'equipment_list': safetyWorkEquipmentListController.text,
        },
      },
    };

    await HttpRequest.httpPostRequest(
      bodyData: sendSaveTaskRiskTestData,
      endPoint: HttpUrls.saveTaskRiskAssistantsSafetyHzard,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          clearValues();
          // Get.to(() => RiskAssessmentScreen());
        }
      }
    });
  }

  saveTaskRiskAssistantsChemicalHazard() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> sendSaveTaskRiskTestData = {
      "Task_Id_": int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      "User_Details_Id_": int.parse(upcomingInspectionsController
          .taskUserDetails[0]['Task_User_Details_Id']
          .toString()),
      "chemical_hazard_": {
        'cleaning_products': {
          "risk_description": chemicalCleaningRiskDescriptionController.text,
          "initial_score": chemicalCleaningInitialScoreController.text,
          // "go": chemicalCleaningGoController.text,
          'mitigation_measure': chemicalCleaningMitigationController.text,
          'final_score': chemicalCleaningFinalScoreController.text,
          'no_go': chemicalCleaningNogoController.text,
          // 'equipment_list': chemicalCleaningEquipmentListController.text,
        },
        'pesticide': {
          "risk_description": chemicalPesticideRiskDescriptionController.text,
          "initial_score": chemicalPesticideInitialScoreController.text,
          // "go": chemicalPesticideGoController.text,
          'mitigation_measure': chemicalPesticideMitigationController.text,
          'final_score': chemicalPesticideFinalScoreController.text,
          'no_go': chemicalPesticideNogoController.text,
          // 'equipment_list': chemicalPesticideEquipmentListController.text,
        },
        'asbestos': {
          "risk_description": chemicalAsbestosRiskDescriptionController.text,
          "initial_score": chemicalAsbestosInitialScoreController.text,
          // "go": chemicalAsbestosGoController.text,
          'mitigation_measure': chemicalAsbestosMitigationController.text,
          'final_score': chemicalAsbestosFinalScoreController.text,
          'no_go': chemicalAsbestosNogoController.text,
          // 'equipment_list': chemicalAsbestosEquipmentListController.text,
        }
      },
    };

    await HttpRequest.httpPostRequest(
      bodyData: sendSaveTaskRiskTestData,
      endPoint: HttpUrls.saveTaskRiskAssistantsChemicalHazard,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          clearValues();
          // Get.to(() => RiskAssessmentScreen());
        }
      }
    });
  }

  saveTaskRiskAssistantsBiologicalHazard() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> sendSaveTaskRiskTestData = {
      "Task_Id_": int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      "User_Details_Id_": int.parse(upcomingInspectionsController
          .taskUserDetails[0]['Task_User_Details_Id']
          .toString()),
      "biological_hazard_": {
        'mold': {
          "risk_description": biologicalMoldRiskDescriptionController.text,
          "initial_score": biologicalMoldInitialScoreController.text,
          // "go": biologicalMoldGoController.text,
          'mitigation_measure': biologicalMoldMitigationController.text,
          'final_score': biologicalMoldFinalScoreController.text,
          'no_go': biologicalMoldNogoController.text,
          // 'equipment_list': biologicalMoldEquipmentListController.text,
        }
      },
    };

    await HttpRequest.httpPostRequest(
      bodyData: sendSaveTaskRiskTestData,
      endPoint: HttpUrls.saveTaskRiskAssistantsBiologicalHazard,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          clearValues();
          // Get.to(() => RiskAssessmentScreen());
        }
      }
    });
  }

  saveTaskRiskAssistantsErgonomicsHazard() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');
    Map<String, dynamic> sendSaveTaskRiskTestData = {
      "Task_Id_": int.parse(upcomingInspectionsController.taskDetailsData[0]
              ['Task_Id']
          .toString()),
      "User_Details_Id_": int.parse(upcomingInspectionsController
          .taskUserDetails[0]['Task_User_Details_Id']
          .toString()),
      "ergonomics_hazard_": {
        'repetition': {
          "risk_description":
              erganomicsRepetitionRiskDescriptionController.text,
          "initial_score": erganomicsRepetitionInitialScoreController.text,
          // "go": erganomicsRepetitionGoController.text,
          'mitigation_measure': erganomicsRepetitionMitigationController.text,
          'final_score': erganomicsRepetitionFinalScoreController.text,
          'no_go': erganomicsRepetitionNogoController.text,
          // 'equipment_list': erganomicsRepetitionEquipmentListController.text,
        },
        'lifting': {
          "risk_description": erganomicsLiftingRiskDescriptionController.text,
          "initial_score": erganomicsLiftingInitialScoreController.text,
          // "go": erganomicsLiftingGoController.text,
          'mitigation_measure': erganomicsLiftingMitigationController.text,
          'final_score': erganomicsLiftingFinalScoreController.text,
          'no_go': erganomicsLiftingNogoController.text,
          // 'equipment_list': erganomicsLiftingEquipmentListController.text,
        },
        'awkward_postures': {
          "risk_description": erganomicsAwkwardRiskDescriptionController.text,
          "initial_score": erganomicsAwkwardInitialScoreController.text,
          // "go": erganomicsAwkwardGoController.text,
          'mitigation_measure': erganomicsAwkwardMitigationController.text,
          'final_score': erganomicsAwkwardFinalScoreController.text,
          'no_go': erganomicsAwkwardNogoController.text,
          // 'equipment_list': erganomicsAwkwardEquipmentListController.text,
        },
        'others': {
          "risk_description": erganomicsOthersRiskDescriptionController.text,
          "initial_score": erganomicsOthersInitialScoreController.text,
          // "go": erganomicsOthersGoController.text,
          'mitigation_measure': erganomicsOthersMitigationController.text,
          'final_score': erganomicsOthersFinalScoreController.text,
          'no_go': erganomicsOthersNogoController.text,
          // 'equipment_list': erganomicsOthersEquipmentListController.text,
        }
      },
    };

    await HttpRequest.httpPostRequest(
      bodyData: sendSaveTaskRiskTestData,
      endPoint: HttpUrls.saveTaskRiskAssistantsErgonomicsHazard,
    ).then((value) {
      if (value != null) {
        if (value.statusCode == 200) {
          clearValues();
          // Get.to(() => RiskAssessmentScreen());
        }
      }
    });
  }

  String? isSaftyCheckTextBoxFill() {
    if (safetyFallingRiskDescriptionController.text.isNotEmpty &&
            safetyFallingInitialScoreController.text.isNotEmpty &&
            // safetyFallingGoController.text.isNotEmpty &&
            safetyFallingMitigationController.text.isNotEmpty &&
            safetyFallingFinalScoreController.text.isNotEmpty &&
            safetyFallingNogoController.text.isNotEmpty &&
            // safetyFallingEquipmentListController.text.isNotEmpty &&
            safetyTrippingRiskDescriptionController.text.isNotEmpty &&
            safetyTrippingInitialScoreController.text.isNotEmpty &&
            // safetyTrippingGoController.text.isNotEmpty &&
            safetyTrippingMitigationController.text.isNotEmpty &&
            safetyTrippingFinalScoreController.text.isNotEmpty &&
            safetyTrippingNogoController.text.isNotEmpty &&
            // safetyTrippingEquipmentListController.text.isNotEmpty &&
            safetyEntanglementRiskDescriptionController.text.isNotEmpty &&
            safetyEntanglementInitialScoreController.text.isNotEmpty &&
            // safetyEntanglementGoController.text.isNotEmpty &&
            safetyEntanglementMitigationController.text.isNotEmpty &&
            safetyEntanglementFinalScoreController.text.isNotEmpty &&
            safetyEntanglementNogoController.text.isNotEmpty &&
            // safetyEntanglementEquipmentListController.text.isNotEmpty &&
            safetyCrushingRiskDescriptionController.text.isNotEmpty &&
            safetyCrushingInitialScoreController.text.isNotEmpty &&
            // safetyCrushingGoController.text.isNotEmpty &&
            safetyCrushingMitigationController.text.isNotEmpty &&
            safetyCrushingFinalScoreController.text.isNotEmpty &&
            safetyCrushingNogoController.text.isNotEmpty &&
            // safetyCrushingEquipmentListController.text.isNotEmpty &&
            safetyEnvironmentRiskDescriptionController.text.isNotEmpty &&
            safetyEnvironmentInitialScoreController.text.isNotEmpty &&
            // safetyEnvironmentGoController.text.isNotEmpty &&
            safetyEnvironmentMitigationController.text.isNotEmpty &&
            safetyEnvironmentFinalScoreController.text.isNotEmpty &&
            safetyEnvironmentNogoController.text.isNotEmpty &&
            // safetyEnvironmentEquipmentListController.text.isNotEmpty &&
            safetyElectricalRiskDescriptionController.text.isNotEmpty &&
            safetyElectricalInitialScoreController.text.isNotEmpty &&
            // safetyElectricalGoController.text.isNotEmpty &&
            safetyElectricalMitigationController.text.isNotEmpty &&
            safetyElectricalFinalScoreController.text.isNotEmpty &&
            safetyElectricalNogoController.text.isNotEmpty &&
            // safetyElectricalEquipmentListController.text.isNotEmpty &&
            safetyFaultyRiskDescriptionController.text.isNotEmpty &&
            safetyFaultyInitialScoreController.text.isNotEmpty &&
            // safetyFaultyGoController.text.isNotEmpty &&
            safetyFaultyMitigationController.text.isNotEmpty &&
            safetyFaultyFinalScoreController.text.isNotEmpty &&
            safetyFaultyNogoController.text.isNotEmpty &&
            // safetyFaultyEquipmentListController.text.isNotEmpty &&
            safetyConfinedRiskDescriptionController.text.isNotEmpty &&
            safetyConfinedInitialScoreController.text.isNotEmpty &&
            // safetyConfinedGoController.text.isNotEmpty &&
            safetyConfinedMitigationController.text.isNotEmpty &&
            safetyConfinedFinalScoreController.text.isNotEmpty &&
            safetyConfinedNogoController.text.isNotEmpty &&
            // safetyConfinedEquipmentListController.text.isNotEmpty &&
            safetyWorkRiskDescriptionController.text.isNotEmpty &&
            safetyWorkInitialScoreController.text.isNotEmpty &&
            // safetyWorkGoController.text.isNotEmpty &&
            safetyWorkMitigationController.text.isNotEmpty &&
            safetyWorkFinalScoreController.text.isNotEmpty &&
            safetyWorkNogoController.text.isNotEmpty
        // &&
        // safetyWorkEquipmentListController.text.isNotEmpty
        ) {
      return 'fullyFilled';
    } else if (safetyFallingRiskDescriptionController.text.isNotEmpty ||
        safetyFallingInitialScoreController.text.isNotEmpty ||
        // safetyFallingGoController.text.isNotEmpty ||
        safetyFallingMitigationController.text.isNotEmpty ||
        safetyFallingFinalScoreController.text.isNotEmpty ||
        safetyFallingNogoController.text.isNotEmpty ||
        // safetyFallingEquipmentListController.text.isNotEmpty ||
        safetyTrippingRiskDescriptionController.text.isNotEmpty ||
        safetyTrippingInitialScoreController.text.isNotEmpty ||
        // safetyTrippingGoController.text.isNotEmpty ||
        safetyTrippingMitigationController.text.isNotEmpty ||
        safetyTrippingFinalScoreController.text.isNotEmpty ||
        safetyTrippingNogoController.text.isNotEmpty ||
        // safetyTrippingEquipmentListController.text.isNotEmpty ||
        safetyEntanglementRiskDescriptionController.text.isNotEmpty ||
        safetyEntanglementInitialScoreController.text.isNotEmpty ||
        // safetyEntanglementGoController.text.isNotEmpty ||
        safetyEntanglementMitigationController.text.isNotEmpty ||
        safetyEntanglementFinalScoreController.text.isNotEmpty ||
        safetyEntanglementNogoController.text.isNotEmpty ||
        // safetyEntanglementEquipmentListController.text.isNotEmpty ||
        safetyCrushingRiskDescriptionController.text.isNotEmpty ||
        safetyCrushingInitialScoreController.text.isNotEmpty ||
        // safetyCrushingGoController.text.isNotEmpty ||
        safetyCrushingMitigationController.text.isNotEmpty ||
        safetyCrushingFinalScoreController.text.isNotEmpty ||
        safetyCrushingNogoController.text.isNotEmpty ||
        // safetyCrushingEquipmentListController.text.isNotEmpty ||
        safetyEnvironmentRiskDescriptionController.text.isNotEmpty ||
        safetyEnvironmentInitialScoreController.text.isNotEmpty ||
        // safetyEnvironmentGoController.text.isNotEmpty ||
        safetyEnvironmentMitigationController.text.isNotEmpty ||
        safetyEnvironmentFinalScoreController.text.isNotEmpty ||
        safetyEnvironmentNogoController.text.isNotEmpty ||
        // safetyEnvironmentEquipmentListController.text.isNotEmpty ||
        safetyElectricalRiskDescriptionController.text.isNotEmpty ||
        safetyElectricalInitialScoreController.text.isNotEmpty ||
        // safetyElectricalGoController.text.isNotEmpty ||
        safetyElectricalMitigationController.text.isNotEmpty ||
        safetyElectricalFinalScoreController.text.isNotEmpty ||
        safetyElectricalNogoController.text.isNotEmpty ||
        // safetyElectricalEquipmentListController.text.isNotEmpty ||
        safetyFaultyRiskDescriptionController.text.isNotEmpty ||
        safetyFaultyInitialScoreController.text.isNotEmpty ||
        // safetyFaultyGoController.text.isNotEmpty ||
        safetyFaultyMitigationController.text.isNotEmpty ||
        safetyFaultyFinalScoreController.text.isNotEmpty ||
        safetyFaultyNogoController.text.isNotEmpty ||
        // safetyFaultyEquipmentListController.text.isNotEmpty ||
        safetyConfinedRiskDescriptionController.text.isNotEmpty ||
        safetyConfinedInitialScoreController.text.isNotEmpty ||
        // safetyConfinedGoController.text.isNotEmpty ||
        safetyConfinedMitigationController.text.isNotEmpty ||
        safetyConfinedFinalScoreController.text.isNotEmpty ||
        safetyConfinedNogoController.text.isNotEmpty ||
        // safetyConfinedEquipmentListController.text.isNotEmpty ||
        safetyWorkRiskDescriptionController.text.isNotEmpty ||
        safetyWorkInitialScoreController.text.isNotEmpty ||
        // safetyWorkGoController.text.isNotEmpty ||
        safetyWorkMitigationController.text.isNotEmpty ||
        safetyWorkFinalScoreController.text.isNotEmpty ||
        safetyWorkNogoController.text.isNotEmpty) {
      return 'partiallyFilled';
    } else {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text('All fields are required in saftyHazard')));
      return 'empty';
    }
  }

  String? isChemicalCheckTextBoxFill() {
    if (chemicalCleaningRiskDescriptionController.text.isNotEmpty &&
            chemicalCleaningInitialScoreController.text.isNotEmpty &&
            // chemicalCleaningGoController.text.isNotEmpty &&
            chemicalCleaningMitigationController.text.isNotEmpty &&
            chemicalCleaningFinalScoreController.text.isNotEmpty &&
            chemicalCleaningNogoController.text.isNotEmpty &&
            // chemicalCleaningEquipmentListController.text.isNotEmpty &&
            chemicalPesticideRiskDescriptionController.text.isNotEmpty &&
            chemicalPesticideInitialScoreController.text.isNotEmpty &&
            // chemicalPesticideGoController.text.isNotEmpty &&
            chemicalPesticideMitigationController.text.isNotEmpty &&
            chemicalPesticideFinalScoreController.text.isNotEmpty &&
            chemicalPesticideNogoController.text.isNotEmpty &&
            // chemicalPesticideEquipmentListController.text.isNotEmpty &&
            chemicalAsbestosRiskDescriptionController.text.isNotEmpty &&
            chemicalAsbestosInitialScoreController.text.isNotEmpty &&
            // chemicalAsbestosGoController.text.isNotEmpty &&
            chemicalAsbestosMitigationController.text.isNotEmpty &&
            chemicalAsbestosFinalScoreController.text.isNotEmpty &&
            chemicalAsbestosNogoController.text.isNotEmpty
        //  &&
        // chemicalAsbestosEquipmentListController.text.isNotEmpty

        ) {
      return 'fullyFilled';
    } else if (chemicalCleaningRiskDescriptionController.text.isNotEmpty ||
            chemicalCleaningInitialScoreController.text.isNotEmpty ||
            // chemicalCleaningGoController.text.isNotEmpty ||
            chemicalCleaningMitigationController.text.isNotEmpty ||
            chemicalCleaningFinalScoreController.text.isNotEmpty ||
            chemicalCleaningNogoController.text.isNotEmpty ||
            // chemicalCleaningEquipmentListController.text.isNotEmpty ||
            chemicalPesticideRiskDescriptionController.text.isNotEmpty ||
            chemicalPesticideInitialScoreController.text.isNotEmpty ||
            // chemicalPesticideGoController.text.isNotEmpty ||
            chemicalPesticideMitigationController.text.isNotEmpty ||
            chemicalPesticideFinalScoreController.text.isNotEmpty ||
            chemicalPesticideNogoController.text.isNotEmpty ||
            // chemicalPesticideEquipmentListController.text.isNotEmpty ||
            chemicalAsbestosRiskDescriptionController.text.isNotEmpty ||
            chemicalAsbestosInitialScoreController.text.isNotEmpty ||
            // chemicalAsbestosGoController.text.isNotEmpty ||
            chemicalAsbestosMitigationController.text.isNotEmpty ||
            chemicalAsbestosFinalScoreController.text.isNotEmpty ||
            chemicalAsbestosNogoController.text.isNotEmpty
        //  &&
        // chemicalAsbestosEquipmentListController.text.isNotEmpty))

        ) {
      return 'partiallyFilled';
    } else {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text('All fields are required in chemicalHazard')));
      return 'empty';
    }
  }

  String? isBiologicalCheckTextBoxFill() {
    print('test value isBiologicalCheckTextBoxFill');
    print(biologicalMoldRiskDescriptionController.text.isNotEmpty);

    print(biologicalMoldInitialScoreController.text.isNotEmpty);
    print(biologicalMoldMitigationController.text.isNotEmpty);
    print(biologicalMoldFinalScoreController.text.isNotEmpty);
    print(biologicalMoldNogoController.text.isNotEmpty);

    if (biologicalMoldRiskDescriptionController.text.isNotEmpty &&
            biologicalMoldInitialScoreController.text.isNotEmpty &&
            // biologicalMoldGoController.text.isNotEmpty &&
            biologicalMoldMitigationController.text.isNotEmpty &&
            biologicalMoldFinalScoreController.text.isNotEmpty &&
            biologicalMoldNogoController.text.isNotEmpty
        // &&
        // biologicalMoldEquipmentListController.text.isNotEmpty

        ) {
      return 'fullyFilled';
    } else if (biologicalMoldRiskDescriptionController.text.isNotEmpty ||
        biologicalMoldInitialScoreController.text.isNotEmpty ||
        // biologicalMoldGoController.text.isNotEmpty ||
        biologicalMoldMitigationController.text.isNotEmpty ||
        biologicalMoldFinalScoreController.text.isNotEmpty ||
        biologicalMoldNogoController.text.isNotEmpty) {
      return 'partiallyFilled';
    } else {
      return 'empty';
    }
  }

  String? isErganomicCheckTextBoxFill() {
    if (erganomicsRepetitionRiskDescriptionController.text.isNotEmpty &&
            erganomicsRepetitionInitialScoreController.text.isNotEmpty &&
            // erganomicsRepetitionGoController.text.isNotEmpty &&
            erganomicsRepetitionMitigationController.text.isNotEmpty &&
            erganomicsRepetitionFinalScoreController.text.isNotEmpty &&
            erganomicsRepetitionNogoController.text.isNotEmpty &&
            // erganomicsRepetitionEquipmentListController.text.isNotEmpty &&
            erganomicsLiftingRiskDescriptionController.text.isNotEmpty &&
            erganomicsLiftingInitialScoreController.text.isNotEmpty &&
            // erganomicsRepetitionGoController.text.isNotEmpty &&
            erganomicsLiftingMitigationController.text.isNotEmpty &&
            erganomicsLiftingFinalScoreController.text.isNotEmpty &&
            erganomicsLiftingNogoController.text.isNotEmpty &&
            // erganomicsRepetitionEquipmentListController.text.isNotEmpty &&
            erganomicsAwkwardRiskDescriptionController.text.isNotEmpty &&
            erganomicsAwkwardInitialScoreController.text.isNotEmpty &&
            // erganomicsAwkwardGoController.text.isNotEmpty &&
            erganomicsAwkwardMitigationController.text.isNotEmpty &&
            erganomicsAwkwardFinalScoreController.text.isNotEmpty &&
            erganomicsAwkwardNogoController.text.isNotEmpty &&
            // erganomicsAwkwardEquipmentListController.text.isNotEmpty &&
            erganomicsOthersRiskDescriptionController.text.isNotEmpty &&
            erganomicsOthersInitialScoreController.text.isNotEmpty &&
            // erganomicsOthersGoController.text.isNotEmpty &&
            erganomicsOthersMitigationController.text.isNotEmpty &&
            erganomicsOthersFinalScoreController.text.isNotEmpty &&
            erganomicsOthersNogoController.text.isNotEmpty

        //  &&
        // erganomicsOthersEquipmentListController.text.isNotEmpty

        ) {
      return 'fullyFilled';
    } else if (erganomicsRepetitionRiskDescriptionController.text.isNotEmpty ||
        erganomicsRepetitionInitialScoreController.text.isNotEmpty ||
        // erganomicsRepetitionGoController.text.isNotEmpty ||
        erganomicsRepetitionMitigationController.text.isNotEmpty ||
        erganomicsRepetitionFinalScoreController.text.isNotEmpty ||
        erganomicsRepetitionNogoController.text.isNotEmpty ||
        // erganomicsRepetitionEquipmentListController.text.isNotEmpty ||
        erganomicsLiftingRiskDescriptionController.text.isNotEmpty ||
        erganomicsLiftingInitialScoreController.text.isNotEmpty ||
        // erganomicsRepetitionGoController.text.isNotEmpty ||
        erganomicsLiftingMitigationController.text.isNotEmpty ||
        erganomicsLiftingFinalScoreController.text.isNotEmpty ||
        erganomicsLiftingNogoController.text.isNotEmpty ||
        // erganomicsRepetitionEquipmentListController.text.isNotEmpty ||
        erganomicsAwkwardRiskDescriptionController.text.isNotEmpty ||
        erganomicsAwkwardInitialScoreController.text.isNotEmpty ||
        // erganomicsAwkwardGoController.text.isNotEmpty ||
        erganomicsAwkwardMitigationController.text.isNotEmpty ||
        erganomicsAwkwardFinalScoreController.text.isNotEmpty ||
        erganomicsAwkwardNogoController.text.isNotEmpty ||
        // erganomicsAwkwardEquipmentListController.text.isNotEmpty ||
        erganomicsOthersRiskDescriptionController.text.isNotEmpty ||
        erganomicsOthersInitialScoreController.text.isNotEmpty ||
        // erganomicsOthersGoController.text.isNotEmpty ||
        erganomicsOthersMitigationController.text.isNotEmpty ||
        erganomicsOthersFinalScoreController.text.isNotEmpty ||
        erganomicsOthersNogoController.text.isNotEmpty) {
      return 'partiallyFilled';
    } else {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text('All fields are required in erganomicHazard')));

      return 'empty';
    }
  }

  String? isPhysicalCheckTextBoxFill() {
    if (physicalNoiseRiskDescriptionController.text.isNotEmpty &&
            physicalNoiseInitialScoreController.text.isNotEmpty &&
            // physicalNoiseGoController.text.isNotEmpty &&
            physicalNoiseMitigationController.text.isNotEmpty &&
            physicalNoiseFinalScoreController.text.isNotEmpty &&
            physicalNoiseNogoController.text.isNotEmpty &&
            // physicalNoiseEquipmentListController.text.isNotEmpty &&
            physicalTemperatureRiskDescriptionController.text.isNotEmpty &&
            physicalTemperatureInitialScoreController.text.isNotEmpty &&
            // physicalTemperatureGoController.text.isNotEmpty &&
            physicalTemperatureMitigationController.text.isNotEmpty &&
            physicalTemperatureFinalScoreController.text.isNotEmpty &&
            physicalTemperatureNogoController.text.isNotEmpty &&
            // physicalTemperatureEquipmentListController.text.isNotEmpty &&
            physicalRadiationRiskDescriptionController.text.isNotEmpty &&
            physicalRadiationInitialScoreController.text.isNotEmpty &&
            // physicalRadiationController.text.isNotEmpty &&
            physicalRadiationMitigationController.text.isNotEmpty &&
            physicalRadiationFinalScoreController.text.isNotEmpty &&
            physicalRadiationNogoController.text.isNotEmpty

        // &&
        // physicalRadiationEquipmentListController.text.isNotEmpty

        ) {
      return 'fullyFilled';
    } else if (physicalNoiseRiskDescriptionController.text.isNotEmpty ||
        physicalNoiseInitialScoreController.text.isNotEmpty ||
        // physicalNoiseGoController.text.isNotEmpty ||
        physicalNoiseMitigationController.text.isNotEmpty ||
        physicalNoiseFinalScoreController.text.isNotEmpty ||
        physicalNoiseNogoController.text.isNotEmpty ||
        // physicalNoiseEquipmentListController.text.isNotEmpty ||
        physicalTemperatureRiskDescriptionController.text.isNotEmpty ||
        physicalTemperatureInitialScoreController.text.isNotEmpty ||
        // physicalTemperatureGoController.text.isNotEmpty ||
        physicalTemperatureMitigationController.text.isNotEmpty ||
        physicalTemperatureFinalScoreController.text.isNotEmpty ||
        physicalTemperatureNogoController.text.isNotEmpty ||
        // physicalTemperatureEquipmentListController.text.isNotEmpty ||
        physicalRadiationRiskDescriptionController.text.isNotEmpty ||
        physicalRadiationInitialScoreController.text.isNotEmpty ||
        // physicalRadiationController.text.isNotEmpty ||
        physicalRadiationMitigationController.text.isNotEmpty ||
        physicalRadiationFinalScoreController.text.isNotEmpty ||
        physicalRadiationNogoController.text.isNotEmpty) {
      return 'partiallyFilled';
    } else {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
      //     content: Text('All fields are required in physicalHazard')));

      return 'empty';
    }
  }

  saveTaskRiskAssistants(
      {required Map<String, dynamic> postBodyData,
      bool isNavigateScreen = false,
      bool isThirdcall = false}) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // int userId = int.parse(sharedPreferences.getString('darlsco_id') ?? '');

    if ((isPhysicalCheckTextBoxFill() == 'fullyFilled' ||
            isSaftyCheckTextBoxFill() == 'fullyFilled' ||
            isChemicalCheckTextBoxFill() == 'fullyFilled' ||
            isBiologicalCheckTextBoxFill() == 'fullyFilled' ||
            isErganomicCheckTextBoxFill() == 'fullyFilled') &&
        (isPhysicalCheckTextBoxFill() != 'partiallyFilled' &&
            isSaftyCheckTextBoxFill() != 'partiallyFilled' &&
            isChemicalCheckTextBoxFill() != 'partiallyFilled' &&
            isBiologicalCheckTextBoxFill() != 'partiallyFilled' &&
            isErganomicCheckTextBoxFill() != 'partiallyFilled')) {
      await HttpRequest.httpPostRequest(
        bodyData: postBodyData,
        // bodyData: {"testing": "123"},

        endPoint: HttpUrls.saveTaskRiskAssistants,
      ).then((value) async {
        if (value != null) {
          if (value.statusCode == 200) {
            if (value.data['Data'].isNotEmpty) {
              if (isNavigateScreen == false) {
                if (isThirdcall == false) {
                  await saveTaskRiskAssistants(
                      postBodyData: getPostDataRiskSection3(),
                      isNavigateScreen: false,
                      isThirdcall: true);
                } else {
                  await saveTaskRiskAssistants(
                      postBodyData: getPostDataRiskSection2(),
                      isNavigateScreen: true);
                }
              } else {
                if (isNavigateScreen) {
                  clearValues();
                  Get.to(() => const RiskAssesmentStopScreen());
                  return;
                }
              }
            }

            // Get.to(() => RiskAssessmentScreen());
          }
        }
      });
    } else {
      if ((isPhysicalCheckTextBoxFill() == 'partiallyFilled' ||
          isSaftyCheckTextBoxFill() == 'partiallyFilled' ||
          isChemicalCheckTextBoxFill() == 'partiallyFilled' ||
          isBiologicalCheckTextBoxFill() == 'partiallyFilled' ||
          isErganomicCheckTextBoxFill() == 'partiallyFilled')) {
        if (isPhysicalCheckTextBoxFill() == 'partiallyFilled') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Please enter full details for Physical Hazard!')));
        }

        if (isChemicalCheckTextBoxFill() == 'partiallyFilled') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Please enter full details for Chemical Hazard!')));
        }

        if (isSaftyCheckTextBoxFill() == 'partiallyFilled') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content: Text('Please enter full details for Safty Hazard! ')));
        }

        //      if(  isBiologicalCheckTextBoxFill() == 'partiallyFilled' ){
        //        ScaffoldMessenger.of(Get.context!)
        // .showSnackBar(const SnackBar(content: Text('BiologicalHazard is not fully filled')));

        //     }
        if (isBiologicalCheckTextBoxFill() == 'partiallyFilled') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content:
                  Text('Please enter full details for Biological Hazard! ')));
        }

        if (isErganomicCheckTextBoxFill() == 'partiallyFilled') {
          ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
              content:
                  Text(' Please enter full details for Erganomic Hazard! ')));
        }
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
            content: Text('Please enter any one risk assessment detail!')));
      }
    }

    // print('inside save task');

    // //  saveTaskRiskAssistantsChemicalHazard();
    // if (physicalNoiseRiskDescriptionController.text.isNotEmpty &&
    //     physicalNoiseInitialScoreController.text.isNotEmpty &&
    //     physicalNoiseGoController.text.isNotEmpty &&
    //     physicalNoiseMitigationController.text.isNotEmpty &&
    //     physicalNoiseFinalScoreController.text.isNotEmpty &&
    //     physicalNoiseNogoController.text.isNotEmpty &&
    //     physicalNoiseEquipmentListController.text.isNotEmpty &&
    //     physicalTemperatureRiskDescriptionController.text.isNotEmpty &&
    //     physicalTemperatureInitialScoreController.text.isNotEmpty &&
    //     physicalTemperatureGoController.text.isNotEmpty &&
    //     physicalTemperatureMitigationController.text.isNotEmpty &&
    //     physicalTemperatureFinalScoreController.text.isNotEmpty &&
    //     physicalTemperatureNogoController.text.isNotEmpty &&
    //     physicalTemperatureEquipmentListController.text.isNotEmpty &&
    //     physicalRadiationRiskDescriptionController.text.isNotEmpty &&
    //     physicalRadiationInitialScoreController.text.isNotEmpty &&
    //     physicalRadiationController.text.isNotEmpty &&
    //     physicalRadiationMitigationController.text.isNotEmpty &&
    //     physicalRadiationFinalScoreController.text.isNotEmpty &&
    //     physicalRadiationNogoController.text.isNotEmpty &&
    //     physicalRadiationEquipmentListController.text.isNotEmpty) {
    //   saveTaskRiskAssistantsPhysicalHazard();
    // } else {
    //   print('physical hazard is empty');
    // }

    // if (safetyFallingRiskDescriptionController.text.isNotEmpty &&
    //     safetyFallingInitialScoreController.text.isNotEmpty &&
    //     safetyFallingGoController.text.isNotEmpty &&
    //     safetyFallingMitigationController.text.isNotEmpty &&
    //     safetyFallingFinalScoreController.text.isNotEmpty &&
    //     safetyFallingNogoController.text.isNotEmpty &&
    //     safetyFallingEquipmentListController.text.isNotEmpty &&
    //     safetyTrippingRiskDescriptionController.text.isNotEmpty &&
    //     safetyTrippingInitialScoreController.text.isNotEmpty &&
    //     safetyTrippingGoController.text.isNotEmpty &&
    //     safetyTrippingMitigationController.text.isNotEmpty &&
    //     safetyTrippingFinalScoreController.text.isNotEmpty &&
    //     safetyTrippingNogoController.text.isNotEmpty &&
    //     safetyTrippingEquipmentListController.text.isNotEmpty &&
    //     safetyEntanglementRiskDescriptionController.text.isNotEmpty &&
    //     safetyEntanglementInitialScoreController.text.isNotEmpty &&
    //     safetyEntanglementGoController.text.isNotEmpty &&
    //     safetyEntanglementMitigationController.text.isNotEmpty &&
    //     safetyEntanglementFinalScoreController.text.isNotEmpty &&
    //     safetyEntanglementNogoController.text.isNotEmpty &&
    //     safetyEntanglementEquipmentListController.text.isNotEmpty &&
    //     safetyCrushingRiskDescriptionController.text.isNotEmpty &&
    //     safetyCrushingInitialScoreController.text.isNotEmpty &&
    //     safetyCrushingGoController.text.isNotEmpty &&
    //     safetyCrushingMitigationController.text.isNotEmpty &&
    //     safetyCrushingFinalScoreController.text.isNotEmpty &&
    //     safetyCrushingNogoController.text.isNotEmpty &&
    //     safetyCrushingEquipmentListController.text.isNotEmpty &&
    //     safetyEnvironmentRiskDescriptionController.text.isNotEmpty &&
    //     safetyEnvironmentInitialScoreController.text.isNotEmpty &&
    //     safetyEnvironmentGoController.text.isNotEmpty &&
    //     safetyEnvironmentMitigationController.text.isNotEmpty &&
    //     safetyEnvironmentFinalScoreController.text.isNotEmpty &&
    //     safetyEnvironmentNogoController.text.isNotEmpty &&
    //     safetyEnvironmentEquipmentListController.text.isNotEmpty &&
    //     safetyElectricalRiskDescriptionController.text.isNotEmpty &&
    //     safetyElectricalInitialScoreController.text.isNotEmpty &&
    //     safetyElectricalGoController.text.isNotEmpty &&
    //     safetyElectricalMitigationController.text.isNotEmpty &&
    //     safetyElectricalFinalScoreController.text.isNotEmpty &&
    //     safetyElectricalNogoController.text.isNotEmpty &&
    //     safetyElectricalEquipmentListController.text.isNotEmpty &&
    //     safetyFaultyRiskDescriptionController.text.isNotEmpty &&
    //     safetyFaultyInitialScoreController.text.isNotEmpty &&
    //     safetyFaultyGoController.text.isNotEmpty &&
    //     safetyFaultyMitigationController.text.isNotEmpty &&
    //     safetyFaultyFinalScoreController.text.isNotEmpty &&
    //     safetyFaultyNogoController.text.isNotEmpty &&
    //     safetyFaultyEquipmentListController.text.isNotEmpty &&
    //     safetyConfinedRiskDescriptionController.text.isNotEmpty &&
    //     safetyConfinedInitialScoreController.text.isNotEmpty &&
    //     safetyConfinedGoController.text.isNotEmpty &&
    //     safetyConfinedMitigationController.text.isNotEmpty &&
    //     safetyConfinedFinalScoreController.text.isNotEmpty &&
    //     safetyConfinedNogoController.text.isNotEmpty &&
    //     safetyConfinedEquipmentListController.text.isNotEmpty &&
    //     safetyWorkRiskDescriptionController.text.isNotEmpty &&
    //     safetyWorkInitialScoreController.text.isNotEmpty &&
    //     safetyWorkGoController.text.isNotEmpty &&
    //     safetyWorkMitigationController.text.isNotEmpty &&
    //     safetyWorkFinalScoreController.text.isNotEmpty &&
    //     safetyWorkNogoController.text.isNotEmpty &&
    //     safetyWorkEquipmentListController.text.isNotEmpty) {
    //   saveTaskRiskAssistantsSafetyHzard();
    // } else {
    //   print('safty hazard is empty');
    // }

    // if (chemicalCleaningRiskDescriptionController.text.isNotEmpty &&
    //     chemicalCleaningInitialScoreController.text.isNotEmpty &&
    //     chemicalCleaningGoController.text.isNotEmpty &&
    //     chemicalCleaningMitigationController.text.isNotEmpty &&
    //     chemicalCleaningFinalScoreController.text.isNotEmpty &&
    //     chemicalCleaningNogoController.text.isNotEmpty &&
    //     chemicalCleaningEquipmentListController.text.isNotEmpty &&
    //     chemicalPesticideRiskDescriptionController.text.isNotEmpty &&
    //     chemicalPesticideInitialScoreController.text.isNotEmpty &&
    //     chemicalPesticideGoController.text.isNotEmpty &&
    //     chemicalPesticideMitigationController.text.isNotEmpty &&
    //     chemicalPesticideFinalScoreController.text.isNotEmpty &&
    //     chemicalPesticideNogoController.text.isNotEmpty &&
    //     chemicalPesticideEquipmentListController.text.isNotEmpty &&
    //     chemicalAsbestosRiskDescriptionController.text.isNotEmpty &&
    //     chemicalAsbestosInitialScoreController.text.isNotEmpty &&
    //     chemicalAsbestosGoController.text.isNotEmpty &&
    //     chemicalAsbestosMitigationController.text.isNotEmpty &&
    //     chemicalAsbestosFinalScoreController.text.isNotEmpty &&
    //     chemicalAsbestosNogoController.text.isNotEmpty &&
    //     chemicalAsbestosEquipmentListController.text.isNotEmpty) {
    //   saveTaskRiskAssistantsChemicalHazard();
    // } else {
    //   print('chemical hazard is empty');
    // }

    // if (biologicalMoldRiskDescriptionController.text.isNotEmpty &&
    //     biologicalMoldInitialScoreController.text.isNotEmpty &&
    //     biologicalMoldGoController.text.isNotEmpty &&
    //     biologicalMoldMitigationController.text.isNotEmpty &&
    //     biologicalMoldFinalScoreController.text.isNotEmpty &&
    //     biologicalMoldNogoController.text.isNotEmpty &&
    //     biologicalMoldEquipmentListController.text.isNotEmpty) {
    //   saveTaskRiskAssistantsBiologicalHazard();
    // } else {
    //   print('biological hazard is empty');
    // }

    // if (erganomicsRepetitionRiskDescriptionController.text.isNotEmpty &&
    //     erganomicsRepetitionInitialScoreController.text.isNotEmpty &&
    //     erganomicsRepetitionGoController.text.isNotEmpty &&
    //     erganomicsRepetitionMitigationController.text.isNotEmpty &&
    //     erganomicsRepetitionFinalScoreController.text.isNotEmpty &&
    //     erganomicsRepetitionNogoController.text.isNotEmpty &&
    //     erganomicsRepetitionEquipmentListController.text.isNotEmpty &&
    //     erganomicsRepetitionRiskDescriptionController.text.isNotEmpty &&
    //     erganomicsRepetitionInitialScoreController.text.isNotEmpty &&
    //     erganomicsRepetitionGoController.text.isNotEmpty &&
    //     erganomicsRepetitionMitigationController.text.isNotEmpty &&
    //     erganomicsRepetitionFinalScoreController.text.isNotEmpty &&
    //     erganomicsRepetitionNogoController.text.isNotEmpty &&
    //     erganomicsRepetitionEquipmentListController.text.isNotEmpty &&
    //     erganomicsAwkwardRiskDescriptionController.text.isNotEmpty &&
    //     erganomicsAwkwardInitialScoreController.text.isNotEmpty &&
    //     erganomicsAwkwardGoController.text.isNotEmpty &&
    //     erganomicsAwkwardMitigationController.text.isNotEmpty &&
    //     erganomicsAwkwardFinalScoreController.text.isNotEmpty &&
    //     erganomicsAwkwardNogoController.text.isNotEmpty &&
    //     erganomicsAwkwardEquipmentListController.text.isNotEmpty &&
    //     erganomicsOthersRiskDescriptionController.text.isNotEmpty &&
    //     erganomicsOthersInitialScoreController.text.isNotEmpty &&
    //     erganomicsOthersGoController.text.isNotEmpty &&
    //     erganomicsOthersMitigationController.text.isNotEmpty &&
    //     erganomicsOthersFinalScoreController.text.isNotEmpty &&
    //     erganomicsOthersNogoController.text.isNotEmpty &&
    //     erganomicsOthersEquipmentListController.text.isNotEmpty) {
    //   saveTaskRiskAssistantsErgonomicsHazard();
    // } else {
    //   print('erganomic hazard is empty');
    // }

    // saveTaskRiskAssistantsChemicalHazard();
  }

  clearValues() {
    physicalNoiseRiskDescriptionController.clear();
    physicalNoiseInitialScoreController.clear();
    // physicalNoiseGoController.clear();
    physicalNoiseMitigationController.clear();
    physicalNoiseFinalScoreController.clear();
    physicalNoiseNogoController.clear();
    // physicalNoiseEquipmentListController.clear();

    physicalTemperatureRiskDescriptionController.clear();
    physicalTemperatureInitialScoreController.clear();
    // physicalTemperatureGoController.clear();
    physicalTemperatureMitigationController.clear();
    physicalTemperatureFinalScoreController.clear();
    physicalTemperatureNogoController.clear();
    // physicalTemperatureEquipmentListController.clear();

    physicalRadiationRiskDescriptionController.clear();
    physicalRadiationInitialScoreController.clear();
    // physicalRadiationController.clear();
    physicalRadiationMitigationController.clear();
    physicalRadiationFinalScoreController.clear();
    physicalRadiationNogoController.clear();
    // physicalRadiationEquipmentListController.clear();

    safetyFallingRiskDescriptionController.clear();
    safetyFallingInitialScoreController.clear();
    // safetyFallingGoController.clear();
    safetyFallingMitigationController.clear();
    safetyFallingFinalScoreController.clear();
    safetyFallingNogoController.clear();
    // safetyFallingEquipmentListController.clear();

    safetyTrippingRiskDescriptionController.clear();
    safetyTrippingInitialScoreController.clear();
    // safetyTrippingGoController.clear();
    safetyTrippingMitigationController.clear();
    safetyTrippingFinalScoreController.clear();
    safetyTrippingNogoController.clear();
    // safetyTrippingEquipmentListController.clear();

    safetyEntanglementRiskDescriptionController.clear();
    safetyEntanglementInitialScoreController.clear();
    // safetyEntanglementGoController.clear();
    safetyEntanglementMitigationController.clear();
    safetyEntanglementFinalScoreController.clear();
    safetyEntanglementNogoController.clear();
    // safetyEntanglementEquipmentListController.clear();

    safetyCrushingRiskDescriptionController.clear();
    safetyCrushingInitialScoreController.clear();
    // safetyCrushingGoController.clear();
    safetyCrushingMitigationController.clear();
    safetyCrushingFinalScoreController.clear();
    safetyCrushingNogoController.clear();
    // safetyCrushingEquipmentListController.clear();

    safetyEnvironmentRiskDescriptionController.clear();
    safetyEnvironmentInitialScoreController.clear();
    // safetyEnvironmentGoController.clear();
    safetyEnvironmentMitigationController.clear();
    safetyEnvironmentFinalScoreController.clear();
    safetyEnvironmentNogoController.clear();
    // safetyEnvironmentEquipmentListController.clear();

    safetyElectricalRiskDescriptionController.clear();
    safetyElectricalInitialScoreController.clear();
    // safetyElectricalGoController.clear();
    safetyElectricalMitigationController.clear();
    safetyElectricalFinalScoreController.clear();
    safetyElectricalNogoController.clear();
    // safetyElectricalEquipmentListController.clear();

    safetyFaultyRiskDescriptionController.clear();
    safetyFaultyInitialScoreController.clear();
    // safetyFaultyGoController.clear();
    safetyFaultyMitigationController.clear();
    safetyFaultyFinalScoreController.clear();
    safetyFaultyNogoController.clear();
    // safetyFaultyEquipmentListController.clear();

    safetyConfinedRiskDescriptionController.clear();
    safetyConfinedInitialScoreController.clear();
    // safetyConfinedGoController.clear();
    safetyConfinedMitigationController.clear();
    safetyConfinedFinalScoreController.clear();
    safetyConfinedNogoController.clear();
    // safetyConfinedEquipmentListController.clear();

    safetyWorkRiskDescriptionController.clear();
    safetyWorkInitialScoreController.clear();
    // safetyWorkGoController.clear();
    safetyWorkMitigationController.clear();
    safetyWorkFinalScoreController.clear();
    safetyWorkNogoController.clear();
    // safetyWorkEquipmentListController.clear();

    chemicalCleaningRiskDescriptionController.clear();
    chemicalCleaningInitialScoreController.clear();
    // chemicalCleaningGoController.clear();
    chemicalCleaningMitigationController.clear();
    chemicalCleaningFinalScoreController.clear();
    chemicalCleaningNogoController.clear();
    // chemicalCleaningEquipmentListController.clear();

    chemicalPesticideRiskDescriptionController.clear();
    chemicalPesticideInitialScoreController.clear();
    // chemicalPesticideGoController.clear();
    chemicalPesticideMitigationController.clear();
    chemicalPesticideFinalScoreController.clear();
    chemicalPesticideNogoController.clear();
    // chemicalPesticideEquipmentListController.clear();

    chemicalAsbestosRiskDescriptionController.clear();
    chemicalAsbestosInitialScoreController.clear();
    // chemicalAsbestosGoController.clear();
    chemicalAsbestosMitigationController.clear();
    chemicalAsbestosFinalScoreController.clear();
    chemicalAsbestosNogoController.clear();
    // chemicalAsbestosEquipmentListController.clear();

    biologicalMoldRiskDescriptionController.clear();
    biologicalMoldInitialScoreController.clear();
    // biologicalMoldGoController.clear();
    biologicalMoldMitigationController.clear();
    biologicalMoldFinalScoreController.clear();
    biologicalMoldNogoController.clear();
    // biologicalMoldEquipmentListController.clear();

    erganomicsRepetitionRiskDescriptionController.clear();
    erganomicsRepetitionInitialScoreController.clear();
    // erganomicsRepetitionGoController.clear();
    erganomicsRepetitionMitigationController.clear();
    erganomicsRepetitionFinalScoreController.clear();
    erganomicsRepetitionNogoController.clear();
    // erganomicsRepetitionEquipmentListController.clear();

    erganomicsLiftingRiskDescriptionController.clear();
    erganomicsLiftingInitialScoreController.clear();
    // erganomicsLiftingGoController.clear();
    erganomicsLiftingMitigationController.clear();
    erganomicsLiftingFinalScoreController.clear();
    erganomicsLiftingNogoController.clear();
    // erganomicsLiftingEquipmentListController.clear();

    erganomicsAwkwardRiskDescriptionController.clear();
    erganomicsAwkwardInitialScoreController.clear();
    // erganomicsAwkwardGoController.clear();
    erganomicsAwkwardMitigationController.clear();
    erganomicsAwkwardFinalScoreController.clear();
    erganomicsAwkwardNogoController.clear();
    // erganomicsAwkwardEquipmentListController.clear();

    erganomicsOthersRiskDescriptionController.clear();
    erganomicsOthersInitialScoreController.clear();
    // erganomicsOthersGoController.clear();
    erganomicsOthersMitigationController.clear();
    erganomicsOthersFinalScoreController.clear();
    erganomicsOthersNogoController.clear();
    // erganomicsOthersEquipmentListController.clear();
  }

  saveTaskStop(statusName, stopNote) async {
    Loader.showLoader();
   

    String dateTimeString = '';
    final dio = Dio();
    try {
      final response = await dio.get('http://worldtimeapi.org/api/ip');
      if (response.statusCode == 200) {
        Loader.stopLoader();
        final data = response.data as Map<String, dynamic>;
        print('jdbfiur $data');
        dateTimeString = data['datetime'];

        final time = data['datetime'].toString().split('T')[1].split('.')[0];
        print('Current time: $time');
      } else {
        Loader.stopLoader();
        print('Failed to fetch time');
      }
    } catch (e) {
      Loader.stopLoader();
      print('Error: $e');
    }

    final checkedEquipments = upcomingInspectionsController.eqList
        .where((element) => element['Checked'].toString() == '1')
        .toList();

if (homeController.isCalliberationSection.value) {
  
      await HttpRequest.httpPostBodyRequest(
        bodyData: {
          "Task_Id_": int.parse(homeController.isCalliberationSection.value
              ? upcomingInspectionsController.taskDetailsDataCalliberation[0]
                      ['Task_Id']
                  .toString()
              : upcomingInspectionsController.taskDetailsData[0]['Task_Id']
                  .toString()),
          "User_Details_Id_": int.parse(
              homeController.isCalliberationSection.value
                  ? upcomingInspectionsController
                      .taskUserDetailsCalliberation[0]['User_Details_Id']
                      .toString()
                  : upcomingInspectionsController.taskUserDetails[0]
                          ['User_Details_Id']
                      .toString()),
          'Stop_Notes_': stopNote,
          "Task_User_Details_Id_": int.parse(
              homeController.isCalliberationSection.value
                  ? upcomingInspectionsController
                      .taskUserDetailsCalliberation[0]['Task_User_Details_Id']
                      .toString()
                  : upcomingInspectionsController.taskUserDetails[0]
                          ['Task_User_Details_Id']
                      .toString()),
          "Stop_Date_Time_": dateTimeString.split('.')[0].isEmpty
              ? DateTime.now().toIso8601String()
              : dateTimeString.split('.')[0],
          "Equipments": upcomingInspectionsController.eqList,
          "Status_Id": homeController.isCalliberationSection.value
              ? '0'
              : upcomingInspectionsController.isEquipmentSelected.value == false
                  ? tcontoller.taskStatusList
                      .where((element) =>
                          element['Task_Status_Name'].toString() == statusName)
                      .toList()[0]['Task_Status_Id']
                  : 11,
          "Status_Name":
              upcomingInspectionsController.isEquipmentSelected.value == false
                  ? statusName
                  : 'Attended',
          "Finish_Notes": tcontoller.stopScreenFinishTextController.text,
        },
        // bodyData: {"testing": "123"},

        endPoint: homeController.isCalliberationSection.value
            ? HttpUrls.saveTaskStopCalliberation
            : HttpUrls.saveTaskStop,
      ).then((value) {
        print(value);

        if (value != null) {
          if (value.statusCode == 200) {
            if (value.data[0].isNotEmpty) {
              // upcomingInspectionsController.todayTaskListData.clear();
              // upcomingInspectionsController.yesterdayTaskListData.clear();
              // upcomingInspectionsController.tommorowTaskListData.clear();
              tcontoller.stopScreenFinishTextController.clear();
              // Loader.stopLoader();
              tcontoller.selectedStatusValue.value = '';
              tcontoller.stopScreenTextController.clear();
              bool areAnyTwoTrue = [
                    homeController.isTrainingEnabled,
                    homeController.isInspectionEnabled,
                    homeController.isCalliberationEnabled
                  ].where((element) => element).length >=
                  2;
              Get.offAll(() => TrainingInspectionScreen(
                    selectedIndex: homeController.isInspectionEnabled &&
                                homeController.isTrainingEnabled &&
                                homeController.isCalliberationEnabled ||
                            !homeController.isInspectionEnabled &&
                                !homeController.isTrainingEnabled &&
                                !homeController.isCalliberationEnabled
                        ? 2
                        : areAnyTwoTrue
                            ? 1
                            : 0,
                  ));

              // Get.offAll( const TrainingInspectionScreen());
            }
            // Get.to(() => RiskAssessmentScreen());
          }
        }
      });
} else {
  
      await HttpRequest.httpPostRequest(
        bodyData: {
          "Task_Id_": int.parse(homeController.isCalliberationSection.value
              ? upcomingInspectionsController.taskDetailsDataCalliberation[0]
                      ['Task_Id']
                  .toString()
              : upcomingInspectionsController.taskDetailsData[0]['Task_Id']
                  .toString()),
          "User_Details_Id_": int.parse(
              homeController.isCalliberationSection.value
                  ? upcomingInspectionsController
                      .taskUserDetailsCalliberation[0]['User_Details_Id']
                      .toString()
                  : upcomingInspectionsController.taskUserDetails[0]
                          ['User_Details_Id']
                      .toString()),
          'Stop_Notes_': stopNote,
          "Task_User_Details_Id_": int.parse(
              homeController.isCalliberationSection.value
                  ? upcomingInspectionsController
                      .taskUserDetailsCalliberation[0]['Task_User_Details_Id']
                      .toString()
                  : upcomingInspectionsController.taskUserDetails[0]
                          ['Task_User_Details_Id']
                      .toString()),
          "Stop_Date_Time_": dateTimeString.split('.')[0].isEmpty
              ? DateTime.now().toIso8601String()
              : dateTimeString.split('.')[0],
          "Equipments": upcomingInspectionsController.eqList,
          "Status_Id": homeController.isCalliberationSection.value
              ? '0'
              : upcomingInspectionsController.isEquipmentSelected.value == false
                  ? tcontoller.taskStatusList
                      .where((element) =>
                          element['Task_Status_Name'].toString() == statusName)
                      .toList()[0]['Task_Status_Id']
                  : 11,
          "Status_Name":
              upcomingInspectionsController.isEquipmentSelected.value == false
                  ? statusName
                  : 'Attended',
          "Finish_Notes": tcontoller.stopScreenFinishTextController.text,
        },
        // bodyData: {"testing": "123"},

        endPoint: homeController.isCalliberationSection.value
            ? HttpUrls.saveTaskStopCalliberation
            : HttpUrls.saveTaskStop,
      ).then((value) {
        print(value);

        if (value != null) {
          if (value.statusCode == 200) {
            if (value.data[0].isNotEmpty) {
              // upcomingInspectionsController.todayTaskListData.clear();
              // upcomingInspectionsController.yesterdayTaskListData.clear();
              // upcomingInspectionsController.tommorowTaskListData.clear();
              tcontoller.stopScreenFinishTextController.clear();
              // Loader.stopLoader();
              tcontoller.selectedStatusValue.value = '';
              tcontoller.stopScreenTextController.clear();
              bool areAnyTwoTrue = [
                    homeController.isTrainingEnabled,
                    homeController.isInspectionEnabled,
                    homeController.isCalliberationEnabled
                  ].where((element) => element).length >=
                  2;
              Get.offAll(() => TrainingInspectionScreen(
                    selectedIndex: homeController.isInspectionEnabled &&
                                homeController.isTrainingEnabled &&
                                homeController.isCalliberationEnabled ||
                            !homeController.isInspectionEnabled &&
                                !homeController.isTrainingEnabled &&
                                !homeController.isCalliberationEnabled
                        ? 2
                        : areAnyTwoTrue
                            ? 1
                            : 0,
                  ));

              // Get.offAll( const TrainingInspectionScreen());
            }
            // Get.to(() => RiskAssessmentScreen());
          }
        }
      });
}
    
  }
}
