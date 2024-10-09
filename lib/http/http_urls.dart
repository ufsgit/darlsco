class HttpUrls {
  //  static String baseUrl = 'http://3.89.129.51:3514';
 
  static String baseUrl = 'http://34.228.212.237:3514'; //  new live

//   static String baseUrl = 'https://7413-103-214-232-132.ngrok-free.app';

  static String agentLogin = '/Login/Agent_Login/';
  static String saveOrderApp = '/Customer_Training/Save_Order_App/';

  static String getOtp = '/public_Data/Get_OTP/';

  static String checkOtp = '/public_Data/Check_OTP/';

  static String notificationUrl = '/Customer_Request_Notification';

  static String notificationUrlReschedule =
      '/Task_Reschedule_Request_Notification';
  static String getTrainingCourse = '/Public_Data/Get_Training_Course/';

  static String saveCustomerRequest = '/Customer/Save_Customer_Request/';

  static String loadTaskStatusApp = '/Customer/Load_Task_Status_App/';

  static String getItemDetails = '/Public_Data/Get_Training_Course_Details_App';
  static String saveCustomerRequestExpiringEquipment =
      '/Customer/Save_Customer_Request_Expiring_Equipment/';
  static String getCustomerEquipments =
      '/Customer/Get_Customer_Location_Equipments/';

  static String getCustomerPlace = '/Customer/get_Customer_Place/';

  static String saveEnquiries = '/public_Data/Save_Enquiries/';

  static String getCustomerTask = '/Customer/Get_Customer_Task/';
  static String saveProfile = '/Customer_Training/Save_Customer_Details_App/';
  static String getProfile =
      '/Customer_Training/Get_Customer_Details_App_Data/';

  static String getUserTask = '/Customer/Get_User_Task/';

  static String getUserTaskDateRange = '/Customer/Get_User_Task_Date_Range/';

  static String getTaskDetails = '/Customer/Get_Task_Details/';

  static String saveTaskDetails = '/Customer/save_task_details/';

  static String getTestEquipment = '/Customer/Get_Test_Equpitment/';

  static String getTestDocument = '/Customer/Get_Test_Document/';

  static String saveTaskTest = '/Customer/Save_Task_Test/';

  static String searchExpiringInspections =
      '/Customer/Search_Expiring_Inspection_Report_App/';

  static String getTestppe = '/Customer/Get_Test_PPE/';

  static String saveTaskRiskAssistants = '/Customer/Save_Task_Risk_Assistants/';

  static String saveTaskRiskAssistantsPhysicalHazard =
      '/Customer/Save_Task_Risk_Assistants_physical_hazard/';

  static String saveTaskRiskAssistantsSafetyHzard =
      '/Customer/Save_Task_Risk_Assistants_safety_hazard/';

  static String saveTaskRiskAssistantsChemicalHazard =
      '/Customer/Save_Task_Risk_Assistants_chemical_hazard/';

  static String saveTaskRiskAssistantsBiologicalHazard =
      '/Customer/Save_Task_Risk_Assistants_biological_hazard/';

  static String saveTaskRiskAssistantsErgonomicsHazard =
      '/Customer/Save_Task_Risk_Assistants_ergonomics_hazard/';
  static String getTotalEquipments = '/Customer/Get_Total_Equipments/';

  static String saveTaskStop = '/Customer/Save_Task_Stop/';

  static String savePublicInspection = '/public_Data/Save_Public_Inspection/';
  static String saveCustomerReschedule = '/Customer/Save_Customer_Reschedule/';

  static String getFullUsers = '/Customer/Get_Full_Users/';

  static String changeTaskUser = '/Customer/Change_Task_User/';

  // static String changeTaskUser = '/Customer/Change_Task_User/';
  static String checkVersion = '/Public_Data/Check_Version/';

//training section urls
//endpoints
  static String imageBase =
      'http://darlsco-files.s3-website.ap-south-1.amazonaws.com/';
  static String saveToCart = '/Public_Data/Save_Item_Cart/';

  static String saveTrainee = '/Public_Data/Save_Trainee_Details_App/';
  static String saveOrder = '/Customer_Training/Save_Order_App/';
  static String getOrderItems = '/Order_Master/Get_Customer_Order_Details/';
  static String getOtpUrl = '/Public_Data/Get_OTP_New/';
  static String getOrder = '/Order_Master/Get_Customer_Order_Details/1';
  static String traineeReassign = '/Customer_Training/Trainer_Reassign/';
  static String trainingCourseStop = '/Customer_Training/Training_Course_Stop/';
  static String getCartItem = '/Public_Data/Search_Item_Cart/';
  static String deleteCartItem = '/Public_Data/Delete_Item_Cart/';
  static String rescheduleCourse =
      '/Customer_Training/Save_Reschedule_Course_App/';
  static String getCount = '/Order_Master/Get_Training_Task_Count/';
  static String getTodayTask = '/Order_Master/Get_Training_Task_Details_Now/';
  static String getUpComingTask =
      '/Order_Master/Get_Training_Task_Details_Future/';
  static String getTrainingAttended =
      '/Order_Master/Get_Training_Task_Details/';
  static String reAssignTrainer = '/Customer_Training/Trainer_Reassign/';
  static String getTraineeDetails =
      '/Customer_Training/Get_Trainee_Details_App/';
  static String startTrainingCourse =
      '/Customer_Training/Save_Training_Course_Start/';
  static String stopTrainingCourse = '/Customer_Training/Training_Course_Stop/';
  static String saveAttendance = '/Customer_Training/Save_Trainee_Attendance/';
  static String getPriceDetails = '/Order_Master/Get_Customer_Order_Details/1';
  static String examFailedDetails = '/Customer_Training/Get_Exam_Fail_Details/';
  static String examFailedTraineeDetails =
      '/Customer_Training/Get_Exam_Fail_Trainee_Details/';
  static String locationDetails = '/Public_Data/Get_Location_App/';
  static String locationDetailsCount =
      '/Trainig_Course/Get_Location_Trainee_Details_Count_App/';

  static String getTrainerList = '/Customer/Get_Training_Staff/';
  static String getTraineesFirstApp = "/Customer/First_Start_App/";
  static String eligibilityDetails = "/Customer/Check_Eligibility_App/";
  static String saveEligibilityExamSave =
      '/Customer_Training/Update_Trainee_Eligibility_App/';
  static String getExamDetailsNow = "/Order_Master/Get_Exam_Details_Now/";
  static String stopExam = '/Customer_Training/Exam_Course_Stop/';
  static String startExam = '/Customer_Training/Save_Exam_Attendance_Start/';

  static String rescheduleExam = '/Customer_Training/Save_Reschedule_Exam_App';

  static String saveTraineeRassign = '/Customer_Training/Save_Trainee_Reassign';

  static String getIndividualTrainee =
      '/Customer_Training/Get_Individual_Training_Details/';

  static String saveTraineeRetake = '/Customer/Save_Trainee_Retake_App/';

  static String searchFaildDetailsApp = '/Customer/Search_Failed_Details_App/';

  static String searchFailedDetailsTrainees =
      '/Customer/Search_Failed_Details_App_Trainees/';

  static String getCategoryEligibility =
      '/Public_Data/Get_Category_Eligibility_Criteria_And_Documents_Required';

  static String certificateView = '/Order_Master/Get_Certificate_Details_App/';
  static String viewAddTraineeDetails =
      '/Training_Order_Request_Master/Get_Order_Details_Trainee/';

  static String startExamOrTrainging =
      '/Customer_Training/Start_Training_Exam_App/';

  static String searchEmiratesId =
      '/training_Order_Request_Master/fetchTraineeDetailsByEmiratesId';
  static String getAllUserTaskStatus = '/Customer/Get_All_Users_Task_Status/';
  static String updateItemCartQuatity =
      '/Public_Data/Update_Itemcart_Quantity/';
  static String verifyCustomerProfile = '/Customer_Training/Verify_Profile/';
  static String getSpecificOrderDetails =
      '/Order_Master/Get_Customer_Order_Details_New/';

  static String getUserChangeStatus = '/Customer/Get_User_Change_Status/';
  static String deleteItemCart = '/Public_Data/Delete_item_cart_WithDevice_Id/';
}
