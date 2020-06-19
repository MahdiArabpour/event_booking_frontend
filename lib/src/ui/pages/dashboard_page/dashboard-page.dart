import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/events_tab.dart';
import './widgets/over_flow_menu.dart';
import './widgets/booked_events_tab.dart';
import '../../global/widgets/my_scaffold.dart';
import './widgets/modal_bottom_sheet_body.dart';
import './tab_bar_indicator_painter/circle_tab_indicator.dart';
import '../../global/providers/token_provider.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = "/dashboard-page";

  void _onAddButtonPressed(BuildContext ctx) => showModalBottomSheet(
        context: ctx,
        builder: (context) => ModalBottomSheetBody(
          token: Provider.of<TokenProvider>(ctx).token,
        ),
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
          indicator: CircleTabIndicator(
              strokeWidth: 4.0,
              lineWidth: MediaQuery.of(context).size.width / 3),
          tabs: <Widget>[
            Tab(
              icon: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Icon(Icons.event)
                  : null,
              text: "Events",
            ),
            Tab(
              icon: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Icon(Icons.bookmark)
                  : null,
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
