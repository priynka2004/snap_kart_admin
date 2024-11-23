import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/auth/provider/auth_provider.dart';
import 'package:snap_kart_admin/auth/view/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(onPressed: (){
         logout(context);
      },icon: Icon(Icons.logout),
      ),
    );
  }
  Future logout(BuildContext context)async{
   final provider = Provider.of<AuthProvider>(context,listen: false);
   await provider.logout();
   if(provider.errorMessage==null){
     if(context.mounted){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
       return LoginScreen();
     }));
   }}
  }
}
