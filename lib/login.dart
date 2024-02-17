// ignore_for_file: prefer_const_constructors
import 'package:isproject/firebase_services/auth.dart';
import 'package:isproject/home.dart';
import 'package:isproject/register.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   final emailAddress = TextEditingController();
  final password = TextEditingController();
  
 
  @override
   dispose() {
    // TODO: implement dispose
    emailAddress.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(162, 194, 239, 241),

      appBar: AppBar(
        backgroundColor:Colors.black12,
        title: Text('Sign in'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  widthScreen>600 ?  EdgeInsets.all(158.0) : EdgeInsets.all(38),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(width: 4),borderRadius: BorderRadius.circular(11)),
                padding: EdgeInsets.all(11),
                child: Text('Welcom to IS assistant',style: TextStyle(fontSize: 30,
              fontStyle:FontStyle.italic,fontWeight: FontWeight.w600
              ),),),
              SizedBox(height: 100,),
            TextField(
              controller: emailAddress,
              keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      suffixIcon: Icon(Icons.email),
                      hintText: 'Enter your email',
                    ),
                  ),
                    SizedBox(height: 22,),
                  TextField(
                    controller: password,
                     obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(8),
                      suffixIcon: Icon(Icons.visibility),
                      hintText: 'Enter your password',
                    ),
                  ),
                    SizedBox(height: 22,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('Do not have an account?',style: TextStyle(fontSize: 17),),
                      TextButton(onPressed: () {
                        Navigator.pushReplacement(
                  context,
                   MaterialPageRoute(
                      builder: (BuildContext context) =>  Register()));
                      }, 
                      child: Text('Sign up',style: TextStyle(fontSize: 17)))
                    ],),
                    SizedBox(height: 54,),
                    ElevatedButton(
         onPressed: ()async{
        await  Auth().login(emailAddress: emailAddress.text, password: password.text);
          Navigator.pushReplacement(
                  context,
                   MaterialPageRoute(
                      builder: (BuildContext context) =>  Home()));
         },
         style: ButtonStyle(
           backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 3, 96, 236)),
           padding: MaterialStateProperty.all(EdgeInsets.all(12)),
           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
         child: Text("Sign in", style: TextStyle(fontSize: 19,color: Colors.white),),
      ),
              ],
              
            ),
        ),
      ),
      
    );
  }
}