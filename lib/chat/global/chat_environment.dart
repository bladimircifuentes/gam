class ChatEnvironment {
  static String apiUrl    = '';
  static String socketUrl = '';

  static void init(String apiUrl, String socketUrl) {
    ChatEnvironment.apiUrl    = "$apiUrl/mobile";
    ChatEnvironment.socketUrl = socketUrl;
  }
}
