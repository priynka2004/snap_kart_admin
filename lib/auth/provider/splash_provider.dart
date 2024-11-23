import 'package:flutter/cupertino.dart';
import 'package:snap_kart_admin/service/storage_service.dart';

class SplashProvider extends ChangeNotifier{

  bool isLoggedIn = false;


  Future<bool> checkLoggedIn()async{
  String? token =  await  StorageHelper.getToken();
  if(token != null){
    isLoggedIn = true;
  }else{
    isLoggedIn = false;
  }return isLoggedIn;
  }
}