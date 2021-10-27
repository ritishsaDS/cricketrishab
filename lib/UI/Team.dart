import 'package:CricScore_App/Utils/Colors.dart';
import 'package:CricScore_App/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'Teamdetail.dart';

class Teams extends StatefulWidget {
  const Teams({Key key}) : super(key: key);

  @override
  _TeamsState createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<String> teams = [
    'assets/bg/team1.png',
    "assets/icons/wi.png",
    'assets/bg/team4.png',
    "assets/icons/pak.png",
    "assets/icons/zim.png",
    'assets/bg/team3.png',
    "assets/icons/eng.png",
    'assets/bg/team2.png',


    "assets/icons/sl.png",


    "assets/icons/Sa.png",


    "assets/icons/ire.png",
  ];
  List<String> teamName =[
    "India (IND)",
    "West Indies (WI)",
    "Bangladesh (BAN)",
    "Pakistan (PAK)",
    "Zimbabwe (ZIM)",
    "Australia (AUS)",
    "England (ENG)",
    "NewZealand (NZ)",
    "Sri Lanka (SL)",
    "South Africa (SA)",
    "Ireland (IRE)",
  ];
  List<String> teamsquad = [
    "Rohit Sharma, Shubman Gill, Mayank Agarwal, Cheteshwar Pujara, Virat Kohli (Captain), Ajinkya Rahane (vice-captain), Hanuma Vihari, Rishabh Pant (wicket-keeper), R. Ashwin, Ravindra Jadeja, Axar Patel, Washington Sundar, Jasprit Bumrah, Ishant Sharma, Mohd. Shami, Md. Siraj, Shardul Thakur, Umesh Yadav, KL Rahul , Wriddhiman Saha (wicket-keeper). ",
    "Chris Gayle,Darren Bravo,Evin Lewis,Lendl Simmons,Shimron Hetmyer,Andre Russell, Dwayne Bravo, Fabian Allen,Jason Holder, Kieron Pollard, Andre Fletcher, Nicholas Pooran,Akeal Hosein, Fidel Edwards,Hayden Wals, Kevin Sinclai,Obed McCoy,Oshane Thomas,Romario Shepherd,",
    "Mohammad Naim,Mosaddek Hossain,Afif Hossain,Mahedi Hasan, Mahmudullah, ,Mohammad Saifuddin, Shamim Hossain, Shamim Hossain, Soumya Sarkar,Mohammad Mithun, Mohammad Mithun,Nurul Hasan",
    "Abdullah Shafique,Abid Ali,Azhar Ali,Babar Azam,Fawad Alam,Imran Butt,Faheem Ashraf,Mohammad Nawaz,Saud Shakeel,Mohammad Rizwan,Sarfaraz Ahmed,Haris Rauf,Hasan Ali,Mohammad Abbas,Naseem Shah,Nauman Ali,Sajid Khan,Shaheen Afridi,Shahnawaz Dhani,Yasir Shah,Zahid Mahmood",
    "Shumba,Milton Shumba,Tarisai MusakandA,Tinashe Kamunhukamwe,Wesley Madhevere,Dion Myers,Ryan Burl,Sikandar Raza,Regis Chakabva,Tadiwanashe Marumani,Blessing Muzarabani,Donald Tiripano,Luke Jongwe,Richard Ngarava,Tendai Chatara",
    "Ashton Turner,Ben McDermott,Ashton Agar,Dan Christian,Mitchell Marsh,Moises Henriques,Alex Carey,Josh Philippe,Matthew Wade,Adam Zampa,Andrew Tye,Jason Behrendorff,Josh Hazlewood,Mitchell Starc,Mitchell Swepson,Nathan Ellis,Riley Meredith,Tanveer Sangha,Wes Agar",
    "Joe Root (Yorkshire) , James Anderson,Jonny Bairstow (Yorkshire),Dom Bess (Yorkshire), Stuart Broad (Nottinghamshire), Rory Burns (Surrey), Jos Buttler (Lancashire), Zak Crawley (Kent), Sam Curran (Surrey), Haseeb Hameed (Nottinghamshire), Dan Lawrence (Essex), Jack Leach (Somerset), Ollie Pope (Surrey), Ollie Robinson (Sussex), Dom Sibley (Warwickshire), Ben Stokes (Durham), Mark Wood (Durham)",
    "Devon Conway, Henry Nicholls,Kane Williamson, Ross Taylor,Will Young, Colin de Grandhomme, BJ Watling,Tom Blundell, Tom Latham,Ajaz Patel, Kyle Jamieson,Matt Henry, Neil Wagner,Tim Southee, Trent Boult",
    " Asghar Afghan,Fareed Ahmad,Hashmatullah Shahidi,Ibrahim Zadran,Najibullah Zadran,Usman Ghani,Karim Janat,Mohammad Nabi,Sharafuddin Ashraf,Afsar Zazai,Rahmanullah Gurbaz,Amir Hamza,Fazal Haque,Naveen-ul-Haq,Rashid Khan",
    "Aiden Markram,David Miller, Janneman Malan, Rassie van der Dussen, Reeza Hendricks, Temba Bavuma, Andile Phehlukwayo, George Linde, Wiaan Mulder, Heinrich Klaasen, Kyle Verreynne, Quinton de Kock, Anrich Nortje, Beuran Hendricks, Bjorn Fortuin, Kagiso Rabada, Keshav Maharaj, Lizaad Williams, Lungi Ngidi, Tabraiz Shamsi",
    "Andy Balbirnie, Harry Tector,William McClintock, George Dockrell,Kevin OBrien, Mark Adair,Paul Stirling, Shane Getkate,Simi Singh, Lorcan Tucker,Stephen Doheny, Barry McCarthy,Benjamin White, Craig Young,Josh Little"
  ];
  // List<String> Indiasquad = [
  //   "Rohit Sharma, Shubman Gill, Mayank Agarwal, Cheteshwar Pujara, Virat Kohli (Captain), Ajinkya Rahane (vice-captain), Hanuma Vihari, Rishabh Pant (wicket-keeper), R. Ashwin, Ravindra Jadeja, Axar Patel, Washington Sundar, Jasprit Bumrah, Ishant Sharma, Mohd. Shami, Md. Siraj, Shardul Thakur, Umesh Yadav, KL Rahul (subject to fitness clearance), Wriddhiman Saha (wicket-keeper; subject to fitness clearance). "
  // ];
  // List<String> England = [
  //   "Joe Root (Yorkshire) Captain"
  //       "James Anderson(Lancashire)",
  //   "Jonny Bairstow (Yorkshire)",
  //   " Dom Bess (Yorkshire)",
  //   "Stuart Broad (Nottinghamshire)",
  //   "Rory Burns (Surrey)",
  //   "Jos Buttler (Lancashire)",
  //   "Zak Crawley (Kent)",
  //   "Sam Curran (Surrey)",
  //   "Haseeb Hameed (Nottinghamshire)",
  //   "Dan Lawrence (Essex)",
  //   "Jack Leach (Somerset)",
  //   "Ollie Pope (Surrey)",
  //   "Ollie Robinson (Sussex)",
  //   "Dom Sibley (Warwickshire)",
  //   "Ben Stokes (Durham)",
  //   "Mark Wood (Durham)"
  // ];
  // List<String> Nz = [
  //   "Devon Conway",
  //   "Henry Nicholls",
  //   "Kane Williamson",
  //   "Ross Taylor",
  //   "Will Young",
  //   "Colin de Grandhomme",
  //   "BJ Watling",
  //   "Tom Blundell",
  //   "Tom Latham",
  //   "Ajaz Patel",
  //   "Kyle Jamieson",
  //   "Matt Henry",
  //   "Neil Wagner",
  //   "Tim Southee",
  //   "Trent Boult"
  // ];
  //
  // List<String> pak = [];
  // List<String> Aus = [
  //   " Ashton Turner",
  //   " Ben McDermott",
  //   " Ashton Agar",
  //   " Dan Christian",
  //   " Mitchell Marsh",
  //   " Moises Henriques",
  //   " Alex Carey",
  //   " Josh Philippe",
  //   " Matthew Wade",
  //   " Adam Zampa",
  //   " Andrew Tye",
  //   " Jason Behrendorff",
  //   " Josh Hazlewood",
  //   " Mitchell Starc",
  //   " Mitchell Swepson",
  //   " Nathan Ellis",
  //   " Riley Meredith",
  //   " Tanveer Sangha",
  //   " Wes Agar",
  // ];
  // List<String> afg = [
  //   " Asghar Afghan",
  //   " Fareed Ahmad",
  //   " Hashmatullah Shahidi",
  //   " Ibrahim Zadran",
  //   " Najibullah Zadran",
  //   " Usman Ghani",
  //   " Karim Janat",
  //   " Mohammad Nabi",
  //   " Sharafuddin Ashraf",
  //   " Afsar Zazai",
  //   " Rahmanullah Gurbaz",
  //   " Amir Hamza",
  //   " Fazal Haque",
  //   " Naveen-ul-Haq",
  //   " Rashid Khan",
  // ];
  // List<String> ban = [
  //   "Mohammad Naim",
  //   "Mohammad Naim",
  //   "Mosaddek Hossain",
  //   "Mosaddek Hossain",
  //   "Afif Hossain",
  //   "Afif Hossain",
  //   "Mahedi Hasan",
  //   "Mahedi Hasan",
  //   "Mahmudullah",
  //   "Mahmudullah",
  //   "Mohammad Saifuddin",
  //   "Mohammad Saifuddin",
  //   "Shakib Al Hasan",
  //   "Shakib Al Hasan",
  //   "Shamim Hossain",
  //   "Shamim Hossain",
  //   "Soumya Sarkar",
  //   "Soumya Sarkar",
  //   "Mohammad Mithun",
  //   "Mohammad Mithun",
  //   "Nurul Hasan",
  // ];
  // List<String> zim = [
  //   "Shumba",
  //   "Milton Shumba",
  //   "Tarisai Musakanda",
  //   "Tinashe Kamunhukamwe",
  //   "Wesley Madhevere",
  //   "Dion Myers",
  //   "Ryan Burl",
  //   "Sikandar Raza",
  //   "Regis Chakabva",
  //   "Tadiwanashe Marumani",
  //   "Blessing Muzarabani",
  //   "Donald Tiripano",
  //   "Luke Jongwe",
  //   "Richard Ngarava",
  //   "Tendai Chatara",
  // ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icons/back.png',
            scale: SizeConfig.blockSizeVertical * 0.5,
          ),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: Text(
                "Teams",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(darkGrey),
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 1),
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Teamsquad(squad: teamsquad[index],name:teamName[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child: Image.asset(
                        teams[index],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3.0,
                                blurRadius: 5.0)
                          ]),
                    ),
                  );
                },
                primary: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: teams.length,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
