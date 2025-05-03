var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ ActiveItZone " + this_year; //it will show in your splash screen
  static String app_name =
      "SRK MATRIMONIAL"; //it will show in your splash screen

  // enter string purchase_code here
  static String purshase_code = '2c55992a-9be2-4050-b802-417300aff65a';

  // configure this
  static const bool HTTPS = true; //if you are using localhost set it to false

  static const DOMAIN_PATH = "matri.srkwebappinnovations.com";
  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
