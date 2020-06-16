import 'package:event_booking/src/ui/global/widgets/my_scaffold.dart';
import 'package:event_booking/src/ui/pages/dashboard_page/widgets/over_flow_menu.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = "/dashboard-page";

  void _onAddButtonPressed(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 25.0,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add a new event",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Price",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Add'),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBarTitle: Text('Event Booking'),
      appBarActions: <Widget>[
        OverFlowMenu(),
      ],
      body: Center(
        child: Container(child: Text('Hello World')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddButtonPressed(context),
        child: Icon(Icons.add),
        tooltip: "Add new Event",
      ),
    );
  }
}
