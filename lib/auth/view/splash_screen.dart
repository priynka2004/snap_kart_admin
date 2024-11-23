import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snap_kart_admin/auth/provider/splash_provider.dart';
import 'package:snap_kart_admin/auth/view/login_screen.dart';
import 'package:snap_kart_admin/dashboard/view/dashboard_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    decideScreen();
  }

  Future<void> decideScreen() async {
    final splashProvider = Provider.of<SplashProvider>(context, listen: false);
    bool isLoggedIn = await splashProvider.checkLoggedIn();


    if (isLoggedIn) {
      if(mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return DashboardScreen();
        }));
      }
    } else {
      if(mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.black,
      body: Center(
        child:Text('')
      ),
    );
  }


}
