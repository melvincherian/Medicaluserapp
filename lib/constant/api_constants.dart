class ApiConstants {
  static const String baseUrl = 'http://31.97.206.144:7021/api';

  static const String register = '$baseUrl/users/register';
  static const String login = '$baseUrl/users/login';

  static const String categoryBase = '$baseUrl/category';
  static const String allCategories = '$categoryBase/allcategories';

  static const String orderstatus='$baseUrl/users/order-status/:userId';

  static const String userLocationapi='$baseUrl/users/add-location';


  static const String deletenotification='$baseUrl/users/:userId/notifications/:notificationId';

  static const String perioidicplan='$baseUrl/users/periodic-order/:userId';
  
  // static const String allMedicines = '$baseUrl/pharmacy/allmedicine';

  static String getMedicinesByCategory(String categoryName) =>
      '$baseUrl/pharmacy/allmedicine?categoryName=$categoryName';

  // Services Endpoints
  // static const String serviceBase = '$baseUrl/service';
  static const String allServices = '$baseUrl/service/allservice';

  static const String pharmacyService = '$baseUrl/pharmacy/getallpjarmacy';

  static const String singlePharmacy =
      '$baseUrl/pharmacy/singlepharmacy/:pharmacyId';

  static const String singleMedicine =
      '$baseUrl/pharmacy/sinle-medicine/:medicineId';

  static const String addtoCart = '$baseUrl/users/addtocart/:userId';

  static const String getCart = '$baseUrl/users/getcart/:userId';

  static const String removeCart =
      '$baseUrl/users/removeitemfromcart/:userId/:medicineId';

  static const String addAddress = '$baseUrl/users/addaddress/:userId';

  static const String getAddress = '$baseUrl/users/getmyaddress/:userId';

  static const String createOrder = '$baseUrl/users/create-booking/:userId';

  static const String getmyOrder = '$baseUrl/users/mybookings/:userId';

  static const String previousOrder =
      '$baseUrl/users/mypreviousbookings/:userId';

  static const String deletePreviousOrder =
      '$baseUrl/users/deleteorders/:userId/:orderId';
  

  static const String getNotifications = '$baseUrl/users/notifications/:userId';

  static const String getuserProfile = '$baseUrl/users/get-user/:userId';

  static const String updateProfileImage =
      '$baseUrl/users/edit-profile/:userId';

  static const String updateUserdata = '$baseUrl/users/updateuser/:userId';

  static const String cancelOrder =
      '$baseUrl/users/cancelorder/:userId/:orderId';

  static const getSinglePreviousOrder =
      '$baseUrl/users/singlepreviousorder/:userId/:orderId';

  static const addqueryapi = '$baseUrl/users/addquery';

  static const sendprescriptionapi =
      '$baseUrl/users/sendprescriptions/:userId/:pharmacyId';

  static const getuserprescription = '$baseUrl/users/userprescriptions/:userId';


  static const reorderapi='$baseUrl/users/reorder/:userId/:orderId';

  static const deleteallnotification='$baseUrl/users/:userId/bulk';

}
