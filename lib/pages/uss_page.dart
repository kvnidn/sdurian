import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class USSState extends StatefulWidget {
  const USSState({Key? key}) : super(key: key);

  @override
  State<USSState> createState() => _USSState();
}

class _USSState extends State<USSState> with TickerProviderStateMixin {
  late TabController _tabController;

  DateTime? selectedDate;
  DateTime today = DateTime.now();
  bool showCalendar = false; // POP CALENDAR

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDate = day;
      today = day;
    });
  }

  void _showTickets() {
    setState(() {
      selectedDate = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5 , vsync: this);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // if (!showCalendar)
                    //   SizedBox(
                    //     height: 21.5,
                    //   ),
                    if (showCalendar) 
                    _buildCalendar()
                    else
                    _buildOfferCarousel([
                      _buildOffers("Special Deals 1", "lib/assets/uss.jpg"),
                      _buildOffers("Special Deals 2", "lib/assets/uss.jpg"),
                      _buildOffers("Special Deals 3", "lib/assets/uss.jpg"),
                    ]),
                    if (!showCalendar)
                      SizedBox(
                        height: 16,
                      ),

                    
                    if (!showCalendar)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            "Tiket yang tersedia",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicator:
                          BoxDecoration(),
                      tabs: <Widget>[
                        Tab(
                          child: _buildCalendarCategory("calendar"),
                        ),
                        Tab(
                          child: _buildDate("Hari Ini", "21 Mei"),
                        ),
                        Tab(
                          child: _buildDate("Rabu", "22 Mei"),
                        ),
                        Tab(
                          child: _buildDate("Kamis", "23 Mei"),
                        ),
                        Tab(
                          child: _buildDate("Jumat", "24 Mei"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10),),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildItemList([
                _buildTabContent("tx", "description", 123),
                _buildTabContent("topxic", "description", 123),
                _buildTabContent("toxxxxpic", "description", 123),
                _buildTabContent("topxxxic", "description", 123),
                _buildTabContent("topxxxic", "description", 123),
                _buildTabContent("topxxic", "description", 123),
              ]),
              _buildItemList([
                _buildTabContent("topic", "description", 123),
                _buildTabContent("topic", "description", 123),
                _buildTabContent("topic", "description", 123),
                _buildTabContent("topic", "description", 123),
                _buildTabContent("topic", "description", 123),
                _buildTabContent("topic", "description", 123),
              ]),
              _buildItemList([
                _buildTabContent("topicB", "description", 123),
                _buildTabContent("topicB", "description", 123),
                _buildTabContent("topicB", "description", 123),
                _buildTabContent("topicB", "description", 123),
                _buildTabContent("topicB", "description", 123),
                _buildTabContent("topicB", "description", 123),
              ]),
              _buildItemList([
                _buildTabContent("topicC", "description", 123),
                _buildTabContent("topicC", "description", 123),
                _buildTabContent("topicC", "description", 123),
                _buildTabContent("topicC", "description", 123),
                _buildTabContent("topicC", "description", 123),
                _buildTabContent("topicC", "description", 123),
              ]),
              _buildItemList([
                _buildTabContent("topicD", "description", 123),
                _buildTabContent("topicD", "description", 123),
                _buildTabContent("topicD", "description", 123),
                _buildTabContent("topicD", "description", 123),
                _buildTabContent("topicD", "description", 123),
                _buildTabContent("topicD", "description", 123),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(List<Widget> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        return cards[index];
      },
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
                color:Color(0xFFFFBF00),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  )),
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

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: _buildCalendar(),
        );
      },
    );
  }
  
  Widget _buildCalendarCategory(String name) {
    return GestureDetector(
      onTap: () {
        if (name == "calendar") {
          setState(() {
            showCalendar = !showCalendar; // Toggle calendar visibility
          });
        }
      },
      child: Container(
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
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFFFFBF00),
              size: 40,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCalendar() {
    return Column(
      children: [
        // Text(today.toString().split(" ")[0]),
        Container(
          height: 260,
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 30,
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
              defaultTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: Colors.red),
            ),
            firstDay: DateTime.utc(2024, 1, 11),
            lastDay: DateTime.utc(2030, 1, 01),
            onDaySelected: (selectedDay, focusedDay) {
              _onDaySelected(selectedDay, focusedDay);
            },
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
      decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 0.1,
              offset: Offset(0, 4.0),
            )
          ]),
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
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

  Widget _buildTabContent(String topic, String description, int price) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.all(10),
      width: 380,
      height: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0, 4.0),
            ),
          ]),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            // left: 10,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {},
              child: Text(
                "Lihat Detail",
                style: TextStyle(
                  color: Color(0xFFFFBF00),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 8.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyFormatter.format(price),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFBF00),
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text("Pilih Ticket"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
  });

  final Widget child;

  @override
  double get minExtent => child.preferredSize.height;
  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

extension on Widget {
  Size get preferredSize => (this is PreferredSizeWidget)
      ? (this as PreferredSizeWidget).preferredSize
      : Size(double.infinity, kToolbarHeight);
}

