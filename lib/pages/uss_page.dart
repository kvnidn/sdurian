import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class USSState extends StatefulWidget {
  const USSState({Key? key}) : super(key: key);

  @override
  State<USSState> createState() => _USSState();
}

class _USSState extends State<USSState> {  

  DateTime? selectedDate;
  DateTime today = DateTime.now();
  bool showCalendar = false; // POP CALENDAR

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _showTickets() {
    setState(() {
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    _buildOfferCarousel([
                      _buildOffers("Special Deals 1", "lib/assets/uss.jpg"),
                      _buildOffers("Special Deals 2", "lib/assets/uss.jpg"),
                      _buildOffers("Special Deals 3", "lib/assets/uss.jpg"),
                    ]),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "Tiket yang tersedia",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),    
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCalendarCategory("Lihat Kalendar"),
                      _buildDate("Hari Ini", "21 Mei"),
                      _buildDate("Rabu", "22 Mei"),
                      _buildDate("Kamis", "23 Mei"),
                      _buildDate("Jumat", "24 Mei"),
                    ],
                  ),
                ),
                if(showCalendar)
                  _buildCalendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffers(String offer, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 360,
              height: 230,
            ),
          ),
          Positioned(
            bottom: 1.2,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(219, 168, 2, 2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(30),
                )
              ),
              child: Text(
                offer,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCarousel(List<Widget> offers) {
    return Container(
      // width: 500,
      // height: 180,
      child: CarouselSlider.builder(
        itemCount: offers.length,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1.0,
        ),
        itemBuilder: (context, index, realIndex) {
          return offers[index];
        },
      ),
    );
  }

  Widget _buildCalendarCategory(String name) {
    return GestureDetector(
      onTap: () {
        if(name == "Lihat Kalendar") {
          setState(() {
            showCalendar = !showCalendar; // BUKA CALENDAR
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 0.1,
              offset: Offset(0, 4.0),
            )
          ]
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: 50,
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFFFBF00),
              size: 40,
            ),
            SizedBox(width: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFFFBF00),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        Text(today.toString().split(" ")[0]),
        Container(
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 40,
            headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFFFFBF00),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(176, 226, 208, 154),
                shape: BoxShape.circle,
              ),
              defaultTextStyle:TextStyle(color: Colors.black),
              weekendTextStyle:TextStyle(color: Colors.red),
            ),
            firstDay:DateTime.utc(2024, 1, 11),
            lastDay: DateTime.utc(2030, 1, 01),
            onDaySelected: _onDaySelected,
          ),

        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showCalendar = false;
            });
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  Widget _buildDate(String day, String date) {
    return Container(
      margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF6F6F6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 0.1,
            offset: Offset(0, 4.0),
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 50,
      
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFFFBF00),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  height: 1,
                  fontSize: 13,
                  color: Color(0xFFFFBF00),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }

}