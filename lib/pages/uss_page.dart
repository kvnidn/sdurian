import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/components/TicketBuilder/ticketui.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class USSState extends StatefulWidget {
  final User user;
  const USSState({Key? key, required this.user}) : super(key: key);

  @override
  State<USSState> createState() => _USSState();
}

class _USSState extends State<USSState> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime selectedDate = DateTime.now();
  DateTime today = DateTime.now();
  bool showCalendar = false; // POP CALENDAR
  late DatePickerController _datePickerController;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDate = day;
      today = day;
      _tabController.animateTo(0);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this, initialIndex: 1);
    _datePickerController = DatePickerController();
  }

  //===== Buat harga weekend atau enggak
  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  double adjustPrice(double price, bool isWeekend) {
    if (isWeekend) {
      return (1.5 * price);
    } else {
      return price;
    }
  }
  // ======

  // Supaya tanggal sebelumnya tidak bisa diclick
  bool isBeforeToday(DateTime day) {
    final now = DateTime.now();
    return day.isBefore(DateTime(now.year, now.month, now.day));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: TColors.secondary,
              expandedHeight: showCalendar ? 400.0 : 260.0,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace, vertical: TSizes.lg * 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat('EEEE').format(DateTime.now())},',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .apply(color: TColors.white),
                              ),
                              Text(
                                DateFormat('dd MMM yyyy')
                                    .format(DateTime.now()),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .apply(color: TColors.white),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${DateFormat.Hm().format(DateTime.now())} WIB',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .apply(
                                          fontSizeFactor: 1.2,
                                          color: TColors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(showCalendar ? 280.0 : 120.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        TSizes.defaultSpace,
                        TSizes.xs,
                        TSizes.defaultSpace,
                        TSizes.spaceBtwItems,
                      ),
                      child: Column(
                        children: [
                          if (showCalendar) _buildCalendar() else _buildDays(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ];
        },
        // Tab bar calendar
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _buildItemList([
              _buildTabContent(selectedDate, "15.00 WIB", "Personal Ticket",
                  "1", adjustPrice(50000, isWeekend(selectedDate))),
              _buildTabContent(selectedDate, "17.00 WIB", "Ticket of Duos", "2",
                  adjustPrice(80000, isWeekend(selectedDate))),
              _buildTabContent(selectedDate, "10.00 WIB", "Trio Gang", "3",
                  adjustPrice(120000, isWeekend(selectedDate))),
              _buildTabContent(selectedDate, "12.00 WIB", "Family Ticket", "5",
                  adjustPrice(300000, isWeekend(selectedDate))),
              _buildTabContent(selectedDate, "21.00 WIB", "Night Time Ticket",
                  "2", adjustPrice(90000, isWeekend(selectedDate))),
            ]),
            for (int i = 0; i <= 7; i++)
              _buildItemList([
                _buildTabContent(
                    DateTime.now().add(Duration(days: i)),
                    "13.00 WIB",
                    "Personal Ticket",
                    "1",
                    adjustPrice(50000,
                        isWeekend(DateTime.now().add(Duration(days: i))))),
                _buildTabContent(
                    DateTime.now().add(Duration(days: i)),
                    "17.00 WIB",
                    "Ticket of Duos",
                    "2",
                    adjustPrice(80000,
                        isWeekend(DateTime.now().add(Duration(days: i))))),
                _buildTabContent(
                    DateTime.now().add(Duration(days: i)),
                    "10.00 WIB",
                    "Trio Gang",
                    "3",
                    adjustPrice(120000,
                        isWeekend(DateTime.now().add(Duration(days: i))))),
                _buildTabContent(
                    DateTime.now().add(Duration(days: i)),
                    "12.00 WIB",
                    "Family Ticket",
                    "5",
                    adjustPrice(300000,
                        isWeekend(DateTime.now().add(Duration(days: i))))),
                _buildTabContent(
                    DateTime.now().add(Duration(days: i)),
                    "21.00 WIB",
                    "Night Time Ticket",
                    "2",
                    adjustPrice(90000,
                        isWeekend(DateTime.now().add(Duration(days: i))))),
              ]),
          ],
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

  // buat table calendar
  Widget _buildCalendar() {
    return Column(
      children: [
        Container(
          height: 260,
          child: TableCalendar(
            locale: "en_US",
            rowHeight: 30,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: TColors.white),
              leftChevronIcon: Icon(Icons.chevron_left, color: TColors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: TColors.white),
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            calendarStyle: CalendarStyle(
              outsideTextStyle: TextStyle(color: TColors.darkerGrey),
              disabledTextStyle: TextStyle(color: TColors.darkerGrey),
              selectedDecoration: BoxDecoration(
                color: TColors.white,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: TColors.darkGrey,
                shape: BoxShape.circle,
              ),
              selectedTextStyle:
                  TextStyle(color: TColors.dark, fontWeight: FontWeight.w900),
              defaultTextStyle:
                  TextStyle(color: TColors.white, fontWeight: FontWeight.w700),
              weekendTextStyle:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
            firstDay: DateTime.utc(2024, 1, 11),
            lastDay: DateTime.utc(2030, 1, 01),
            onDaySelected: (selectedDay, focusedDay) {
              _onDaySelected(selectedDay, focusedDay);
            },
            enabledDayPredicate: (day) => !isBeforeToday(day),
          ),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                showCalendar = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.close_circle, color: TColors.white),
                SizedBox(width: TSizes.sm),
                Text(
                  'Close',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.white, fontWeightDelta: 1),
                ),
              ],
            )),
      ],
    );
  }

  // Tab bar
  Widget _buildDays() {
    return Column(
      children: [
        // Original DatePicker widget
        DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          daysCount: 7,
          initialSelectedDate: DateTime.now(),
          monthTextStyle: TextStyle(color: TColors.white),
          dayTextStyle: TextStyle(color: TColors.white),
          selectedTextColor: TColors.black,
          selectionColor: TColors.white,
          dateTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: TColors.white),
          controller: _datePickerController,
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
              today = date;
              _tabController.animateTo(0);
            });
          },
        ),

        // Button to show TableCalendar
        TextButton(
            onPressed: () {
              setState(() {
                showCalendar = !showCalendar; // Toggle calendar visibility
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.calendar_1, color: TColors.white),
                SizedBox(width: TSizes.sm),
                Text(
                  'Show Calendar',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.white, fontWeightDelta: 1),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildTabContent(
      DateTime date, String time, String name, String person, double price) {
    return TicketUi(
      date: date,
      time: time,
      name: name,
      person: person,
      price: price,
      onTap: () {
        CartItemUSS.addItemToCart(
          date: date,
          time: time,
          name: name,
          person: person,
          price: price.toDouble(),
          amount: 1.0,
          email: widget.user.email,
        );
      },
    );
  }
}
