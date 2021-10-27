import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Gender selectedGender;
  List<Gender> genders = <Gender>[
    const Gender(gender: 'Male'),
    const Gender(gender: 'Female'),
    const Gender(gender: 'Other')
  ];

  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();

  DateTime selectedDate = DateTime.now();

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    dob.text = DateFormat.yMd().format(selectedDate);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, '/Main');
          },
          child: Image.asset('assets/icons/back.png',
            scale: SizeConfig.blockSizeVertical * 0.5,),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(lightBlue),
                          ),
                        ),
                        height: SizeConfig.blockSizeVertical * 14,
                        width: SizeConfig.screenWidth * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/bg/profile.jpg',fit: BoxFit.cover,),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.12,
                        left: SizeConfig.screenWidth * 0.4
                    ),
                    width: SizeConfig.screenWidth,
                    child: ImageIcon(AssetImage('assets/icons/edit icon.png'),color: Color(lightBlue),)),
              ],
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Divider(
                color: Color(lightBlue),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 5.0,
                          spreadRadius: 3.0
                        ),
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(child: Text("Full Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w500
                        ),)),
                        Container(child: TextFormField(
                          controller: fullName,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                        width: SizeConfig.screenWidth * 0.5,),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 5.0,
                              spreadRadius: 3.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(child: Text("Phone No.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),)),
                        Container(child: TextFormField(
                          controller: phone,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                          width: SizeConfig.screenWidth * 0.5,),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 5.0,
                              spreadRadius: 3.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(child: Text("DOB",
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),)),
                        Container(
                          child: TextFormField(
                            controller: dob,
                            readOnly: true,
                            onTap: (){
                              selectDate(context);
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon:ImageIcon(Image.asset('assets/icons/calendar.png',
                              scale: SizeConfig.blockSizeVertical * 0.5,).image),
                            ),
                          ),
                          width: SizeConfig.screenWidth * 0.5,),
                      ],
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 5.0,
                              spreadRadius: 3.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(child: Text("Gender",
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),)),
                        Container(child: DropdownButtonFormField<Gender>(iconEnabledColor: Color(lightBlue),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(
                                  SizeConfig.blockSizeHorizontal),
                              border: InputBorder.none,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              errorStyle:
                              TextStyle(color: Colors.red,)),
                          hint: Text(
                            "Select Gender",
                            style: TextStyle(
                              fontSize:
                              SizeConfig.blockSizeVertical * 1.50,
                            ),
                          ),
                          value: selectedGender,
                          onChanged: (Gender value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                          items: genders.map((Gender gender) {
                            return DropdownMenuItem<Gender>(
                              value: gender,
                              child: Text(
                                gender.gender,
                                style: TextStyle(
                                    fontSize:
                                    SizeConfig.blockSizeVertical *
                                        1.5),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }).toList(),
                        ),
                          width: SizeConfig.screenWidth * 0.5,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Center(
              child: Container(
                width: SizeConfig.screenWidth * 0.5,
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical
                ),
                child: MaterialButton(
                  onPressed: (){},
                  height: SizeConfig.blockSizeVertical * 6,
                  child: Text("Save Now",
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  color: Color(lightBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Gender {
  const Gender({this.gender});
  final String gender;
}

