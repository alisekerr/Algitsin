import 'package:algitsin/feature/view/loggedin_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
         if (snapshot.connectionState==ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator(),);
         }else if(snapshot.hasData){
           return const LoggedinWidget();
         }
         else if(snapshot.hasError){
           return const Center(child: Text("Error...."));
         }
         else{
            return const Text("Try Again...");
         }
        },
      ),
    );
  }
}