class Environment{
  static String subscriptionUrl = 'http://admin.xecasoft.com/xecasoft-admin-ws-api/v1/customer-application';
  static String apiUrl = 'http://qagaw.xecasoft.com/mobile';
  static String socketUrl = 'http://qagawsocket.xecasoft.com';

  static void changeUrl(String url){
    apiUrl = url;
  }
}