// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:isproject/firebase_services/auth.dart';
import 'package:isproject/home.dart';

import 'package:isproject/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool startedEnteringtPassword = false;
  final emailAddress = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  final title = TextEditingController();

  @override
  dispose() {
    // TODO: implement dispose
    emailAddress.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(162, 194, 239, 241),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Register'),
      ),
      body: Padding(
        padding: widthScreen > 600
            ? EdgeInsets.symmetric(horizontal: widthScreen / 4)
            : EdgeInsets.all(38),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    suffixIcon: Icon(Icons.person),
                    hintText: 'Enter your username',
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(8),
                    suffixIcon: Icon(Icons.work),
                    hintText: 'Enter your title',
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                  // we return "null" when something is valid
                  validator: (value) {
                    return value!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Enter a valid email";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,

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
                SizedBox(
                  height: 22,
                ),
                TextFormField(
                  onChanged: (value) {
                    startedEnteringtPassword = true;
                    setState(() {
                      if (value.contains(RegExp(r'.{8,}')) &&
                          value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
                          value.contains(RegExp(r'[a-z]')) &&
                          value.contains(RegExp(r'[0-9]')) &&
                          value.contains(RegExp(r'[A-Z]'))) {
                        startedEnteringtPassword = false;
                      }
                    });
                  },

                  // we return "null" when something is valid
                  validator: (value) {
                    return value!.contains(RegExp(r'.{8,}')) &&
                            value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) &&
                            value.contains(RegExp(r'[a-z]')) &&
                            value.contains(RegExp(r'[0-9]')) &&
                            value.contains(RegExp(r'[A-Z]'))
                        ? null
                        : "Enter a valid password";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(
                  height: 22,
                ),
                startedEnteringtPassword
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password should contains:',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Uppercase',
                            style: TextStyle(
                                color: password.text.contains(RegExp(r'[A-Z]'))
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Text(
                            'Lowercase',
                            style: TextStyle(
                                color: password.text.contains(RegExp(r'[a-z]'))
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Text(
                            'number',
                            style: TextStyle(
                                color: password.text.contains(RegExp(r'[0-9]'))
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Text(
                            'Special character',
                            style: TextStyle(
                                color: password.text.contains(
                                        RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          Text(
                            'At least 8 charachters',
                            style: TextStyle(
                                color: password.text.contains(RegExp(r'.{8,}'))
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      )
                    : SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Login()));
                        },
                        child: Text('Sign in', style: TextStyle(fontSize: 17)))
                  ],
                ),
                SizedBox(
                  height: 54,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                         await Auth().register(email: emailAddress.text, password: password.text, context: context, title: title.text, username: username.text,  );
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 3, 96, 236)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign up",
                            style: TextStyle(fontSize: 19,color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
