import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({super.key});

  @override
  State<Aboutscreen> createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0.5),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back_button.png',
                width: 54.0,
                height: 54.0,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 20),
              child: Text(
                "ABOUT",
                style: TextStyle(
                  color: AppColors.Pink,
                  fontFamily: "Game_Tape",
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alcheringa, also known as "Alcher", is the annual cultural festival of Indian Institute of Technology (IIT), Guwahati. The festival was started in 1996 by a group of students of IIT Guwahati. Spread over 3 days and 4 nights, Alcheringa is conducted towards the end of January every year. The 25th edition held from 30 January 2021 to 2 February 2021, witnessing 80 events.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'The festival features one of the biggest rock band competitions of India, Rock-o-Phonix. The latest edition of Alcheringa was held with limited participation and events pertaining to the ongoing COVID-19 crisis.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Alcheringa, derives its etymology from an Australian aboriginal mythology and translates to "The Eternal Dreamtime\" \n \n In 2002, \'Alcheringa: Yin and Yang\' the concept of four pro-nites was first introduced. \'Alcheringa: Navras\' in 2006, hosted the festival\'s first international act. In 2011, Alcheringa\'s social Initiative \'Udaan - Giving flights to hope\' was started. \'Alcheringa: Echoes of Innocence\' (2018) was the twenty-second edition of the cultural festival .',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Events',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Pronites \n Some notable Indian artists who have earlier performed in Alcheringa are Mika Singh, Lucky Ali, Sonu Nigam, Shaan, Shankar-Ehsaan-Loy, K.K, Mohit Chauhan, Shilpa Rao, Javed Ali, Anoushka Shankar, Vir Das, Kalki Koechlin, Amaan and Ayaan Ali Khan, The Indian Jam Project, Grammy winners Ustaad Shujaat Khan and Pandit Vishwa Mohan Bhatt, Undying Inc, RDB, Remo Fernandes, Raghu Dixit, Euphoria, Indian Ocean, Vaayu, Motherjane and more. \n \n Alcheringa hosts over 80 competitions. Some of the competitions held at Alcheringa are Electric Heels, the group dance competition, Voice of Alcheringa, the solo singing competition, Halla Bol the street play competition, Rock-o-Phonix, the rock band competition, Mr. and Ms. Alcheringa, the personality contest, Crossfade, the scratching competition and Haute Couture, the team based fashion designing event. The Campus Princess is another beauty pageant of Alcheringa which started in its 20th edition, was conducted in association with the Miss India Organisation. The Auditions for Campus Princess were judged by Miss Asia Pacific World 2013 Ms. Srishti Rana. Mute, the Mime competition was judged by Mr Moinul Haque, the winner of the Sangeet Natak Academy Award. \n \n World Carnival \n \n World Carnival is an initiative by Alcheringa to promote cultures from across the world here in the North-Eastern part of the country. Alcheringa has had artists like Ciorras and Fastest feet in Rhythm from the United States, Ne Obliviscaris and poet Omar Musa from Australia, Fasta Duo and Murray Molloy from Ireland, beatboxer Rizumik from Portugal, rock bands Ouzo Bazooka, Tiny Fingers and Orphaned Land from Israel. Alcheringa has also had the jazz band Tropic Green from Singapore, the Portuguese horn player Mickael Faustino, the Algeria Dance Company from Malta, Hungarian flutist David Simon and pianist Janos Palojtay, the German Classical jazz performer Mito, alternate pop music band BETTY from the USA and English hypnotist Andrew Newton and extreme technical metal band Meta Stasis.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Campaign',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Game_Tape',
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Udaan: Giving Flights to Hope\n Udaan is a social initiative by Alcheringa wherein the students of IIT Guwahati visit underprivileged children in various corners of India. Udaan reached 52 cities in 2016. In Alcheringa 2018, "Desh Ka Sandesh" was organised under the umbrella of Udaan. \n\n North East Unveiled \n\n The underlying idea of the campaign North-East Unveiled is to promote a shared identity of this part of the country with the rest other parts of the nation while promoting its tourism, food, general practices and removing any stereotypes about North East India. This was done by releasing a series of videos highlighting the above. The North East Social Entrepreneurship Summit and The North East Townhall Discussions were held during Alcheringa 2016. \n\nSponsors and past associates\n\n Alcheringa has in the past associated with freecharge, Swiggy, OnePlus, Hero MotoCorp, Wipro, State Bank of India, Indian Oil, Maruti Suzuki, Ola, Fast Track, Daikin, Viber, Coca-Cola, KitKat and Baskin Robbins. In the media sector Alcheringa has been associated with the RED FM, The Telegraph, The Assam Tribune, Business India, North East Today, Metalbase India etc.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Game_Tape'),
                      )
                    ],
                  ),
                ),
              ))
            ])),
      ),
    );
  }
}
