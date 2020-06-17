import 'package:flutter/material.dart';

import './widgets/events_tab.dart';
import './widgets/over_flow_menu.dart';
import './widgets/booked_events_tab.dart';
import '../../global/widgets/my_scaffold.dart';
import './widgets/modal_bottom_sheet_body.dart';
import './tab_bar_indicator_painter/circle_tab_indicator.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = "/dashboard-page";

  void _onAddButtonPressed(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => ModalBottomSheetBody(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MyScaffold(
        appBarTitle: Text('Event Booking'),
        appBarActions: <Widget>[
          OverFlowMenu(),
        ],
        appBarBottom: TabBar(
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          indicator: CircleTabIndicator(radius: 3.0),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.event),
              text: "Events",
            ),
            Tab(
              icon: Icon(Icons.bookmark),
              text: "Booked Events",
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            EventsTab(),
            BookedEventsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onAddButtonPressed(context),
          child: Icon(Icons.add),
          tooltip: "Add new Event",
        ),
      ),
    );
  }
}
