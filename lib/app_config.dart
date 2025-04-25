var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ ActiveItZone " + this_year; //it will show in your splash screen
  static String app_name =
      "ACTIVE MATRIMONIAL"; //it will show in your splash screen

  // enter string purchase_code here
  static String purshase_code = 'your_purchase_code';

  // configure this
  static const bool HTTPS = true; //if you are using localhost set it to false

  static const DOMAIN_PATH = "demo.activeitzone.com/matrimonial";
  // do not configure these below
  static const String API_ENDPATH = "api";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
