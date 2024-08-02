import 'package:hotel_finde_hotel/core/storage/shared/shared_pref.dart';

String _baseUrl = 'http://10.0.2.2:8000/api/';
String imageUrl = 'http://10.0.2.2:8000/storage/';

class ApiGetUrl {
  static String getMostPopularRooms = '${_baseUrl}getMostPopularRooms';
  static String getRooms = '${_baseUrl}getRooms';
  static String getUserProfile =
      '${_baseUrl}getUserProfile/${AppSharedPreferences.getUserId()}';
}

class ApiPostUrl {
  static String register = '${_baseUrl}userRegister';
  static String login = '${_baseUrl}hotelLogin';
  static String updateUserProfile = '${_baseUrl}updateUserProfile';
}

class ApiDeleteUrl {}

class ApiPutUrl {}
