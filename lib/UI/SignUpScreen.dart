import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController cPwd = TextEditingController();

  FocusNode fullNameFn;
  FocusNode usernameFn;
  FocusNode pwdFn;
  FocusNode cPwdFn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameFn = FocusNode();
    usernameFn = FocusNode();
    pwdFn = FocusNode();
    cPwdFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFn.dispose();
    usernameFn.dispose();
    pwdFn.dispose();
    cPwdFn.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.05
              ),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              child: Image.asset('assets/bg/cricket bg.png',fit: BoxFit.cover,),
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
              child: Text("Signup",
                style: TextStyle(
                    color: Color(lightBlue),
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 3
                ),),
            ),
            Stack(
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(lightBlue),
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        height: SizeConfig.blockSizeVertical * 14,
                        width: SizeConfig.screenWidth * 0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Upload Profile Pic",textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.1,
                    left: SizeConfig.screenWidth * 0.3
                  ),
                   width: SizeConfig.screenWidth,
                    child: ImageIcon(AssetImage('assets/icons/edit.png'))),
              ],
            ),
            Form(
              key: signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.1,
                      right: SizeConfig.screenWidth * 0.1,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    child: TextFormField(
                      controller: fullName,
                      focusNode: fullNameFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value){
                        fullNameFn.unfocus();
                        FocusScope.of(context).requestFocus(usernameFn);
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5
                        ),
                        hintText: "Full Name",
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
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.1,
                      right: SizeConfig.screenWidth * 0.1,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
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
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.1,
                      right: SizeConfig.screenWidth * 0.1,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    child: TextFormField(
                      controller: pwd,
                      focusNode: pwdFn,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onFieldSubmitted: (value){
                        pwdFn.unfocus();
                        FocusScope.of(context).requestFocus(cPwdFn);
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
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.1,
                      right: SizeConfig.screenWidth * 0.1,
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical,
                    ),
                    child: TextFormField(
                      controller: cPwd,
                      focusNode: cPwdFn,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onFieldSubmitted: (value){
                        cPwdFn.unfocus();
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.5,
                            horizontal: SizeConfig.blockSizeHorizontal * 5
                        ),
                        hintText: "Re-enter Password",
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
                        gradient: LinearGradient(
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
                          Navigator.of(context).pushNamed('/Main');
                        },
                        child: Text("Signup",
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
                      vertical: SizeConfig.blockSizeVertical
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account !",
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
                            Navigator.of(context).pushNamed('/Login');
                          },
                          child: Text("Signin Now",
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
    ));
  }
}
