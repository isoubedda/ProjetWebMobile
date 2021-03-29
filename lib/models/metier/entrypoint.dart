

 class EntryPoint {
//  static String url = "http:/0.0.0.0/";
   static String url = "http://mobile-server.armion.space:8085/";
   String urlPlace;
   String urlUser;
   String urlImage;
   EntryPoint() {
     urlPlace = url+"places";
     urlUser = url+"users";
     urlImage = url+"images";
   }
}