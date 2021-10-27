import 'dart:convert';

import 'package:http/http.dart';
import 'package:CricScore_App/UI/Quizmain.dart';
import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'QUizScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading=false;
  bool isError = false;
  FocusNode usernameFn = FocusNode();
  FocusNode pwdFn = FocusNode();
  bool rememberMe = false;
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("CricScore Says-"),
          content: Container(
            height: SizeConfig.screenHeight*0.20,
            child: Column(
              children: [
                ElevatedButton(
                  child: Row(
                    children: [
                      Image.asset("assets/icons/facebook.png",scale: 22,),
                      Text('Login with Facebook'),
                    ],
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFF3B5998),
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: Row(
                    children: [
                      Image.asset('assets/icons/google-plus.png',scale: 5,),
                      Text('Login with Google'),
                    ],
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFFDD4B39),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

        ),
      );
    });
    // TODO: implement initState
    super.initState();
    
    usernameFn = FocusNode();
    pwdFn = FocusNode();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    
    usernameFn.dispose();
    pwdFn.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Material(

        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                width: double.infinity,
                height: SizeConfig.screenHeight * 0.3,
                decoration: BoxDecoration(image: DecorationImage(
                  image: AssetImage('assets/bg/bg.png')
                )),
                child: Image.asset('assets/icons/appicon.png'
                    ,height: 50,width: 50,),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Live Cricket Score",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2
                ),),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2
                ),
                alignment: Alignment.center,
                child: Text("Signin",
                  style: TextStyle(
                      color: Color(lightBlue),
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.blockSizeVertical * 3
                  ),),
              ),
              Form(
                key: loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.1,
                        vertical: SizeConfig.blockSizeVertical * 3,
                      ),
                      child: TextFormField(
                        controller: username,
                        focusNode: usernameFn,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value){
                          usernameFn.unfocus();
                          FocusScope.of(context).requestFocus(pwdFn);
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5
                          ),
                          hintText: "Username",
                          hintStyle: TextStyle(
                            color: Color(hintGrey),
                            fontWeight: FontWeight.w500,

                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.1,
                        vertical: SizeConfig.blockSizeVertical,
                      ),
                      child: TextFormField(
                        controller: password,
                        focusNode: pwdFn,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onFieldSubmitted: (value){
                          pwdFn.unfocus();
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 1.5,
                              horizontal: SizeConfig.blockSizeHorizontal * 5
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color(hintGrey),
                            fontWeight: FontWeight.w500,

                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Color(lightBlue),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.1,
                        vertical: SizeConfig.blockSizeVertical,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              if(rememberMe == true)
                                setState(() {
                                  rememberMe = false;
                                });
                              else
                                setState(() {
                                  rememberMe = true;
                                });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              children: [
                                Checkbox(value: rememberMe,
                                    onChanged: (value){
                                  setState(() {
                                    rememberMe = value;
                                  });
                                    },
                                activeColor: Color(lightBlue),
                                checkColor: Colors.white,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                Text("Remember Me",
                                style: TextStyle(
                                  color: Color(darkGrey),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.blockSizeVertical * 1.75
                                ),)
                              ],
                            ),
                          ),
                          Text("Forgot Password?",
                            style: TextStyle(
                                color: Color(darkGrey),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 1.75
                            ),)
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: SizeConfig.screenWidth * 0.5,
                        height: SizeConfig.blockSizeVertical * 5,
                        margin: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.1,
                          right: SizeConfig.screenWidth * 0.1,
                          top: SizeConfig.blockSizeVertical * 3,
                          bottom: SizeConfig.blockSizeVertical
                        ),
                        decoration: BoxDecoration(
                            gradient:LinearGradient(
                              colors: [
                                Color(gradientColor1),
                                Color(gradientColor2).withOpacity(0.95),
                              ],
                              begin: Alignment(1.0, -3.0),
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                        ),
                        child: MaterialButton(
                          onPressed: (){
                           setState(() {
                             isLoading=true;
                             signin();
                           });
                          },
                          child:  isLoading
                              ? CircularProgressIndicator(
                            valueColor:
                            new AlwaysStoppedAnimation<
                                Color>(Colors.white),
                          )
                              : Text("SignIn",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          ),

                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                            style: TextStyle(
                                color: Color(darkGrey),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 1.75
                            ),),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed('/SignUp');
                            },
                            child: Text("Signup Now",
                              style: TextStyle(
                                  color: Color(lightBlue),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.blockSizeVertical * 1.75
                              ),),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
  dynamic loginwithserver = new List();
  signin() async {
    try {
      final response = await post(Uri.parse("http://royalgujarati.com/chief/public/api/user/login"), body: {
        "email": username.text,
        "password": password.text,
      });

      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;
        // print(loginwithserver['data']['email']);
        print(loginwithserver);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("usertoken", loginwithserver["token"]["original"]['access_token']);
        preferences.setInt("Userid", loginwithserver["data"][0]['id']);

        preferences.setString("login", "/CustomerLogin");
        showToast("Login Succesfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Quizscreen())); // showToast("");
        //savedata();
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
